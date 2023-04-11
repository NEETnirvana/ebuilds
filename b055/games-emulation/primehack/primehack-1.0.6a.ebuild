# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg-utils pax-utils

DESCRIPTION="Dolphin fork intended to give Metroid Prime Trilogy mouselook controls"
HOMEPAGE="https://forums.dolphin-emu.org/Thread-fork-primehack-fps-controls-and-more-for-metroid-prime"
SRC_URI="https://github.com/shiiion/dolphin/archive/refs/tags/${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="
	alsa bluetooth doc +evdev ffmpeg +gui log profile pulseaudio systemd upnp vulkan
"

S="${WORKDIR}/dolphin-${PV}"

DESTDIR="/opt/${PN}"

RDEPEND="
	app-arch/bzip2:=
	app-arch/xz-utils:=
	app-arch/zstd:=
	dev-libs/hidapi:=
	>=dev-libs/libfmt-8:=
	dev-libs/lzo:=
	dev-libs/pugixml:=
	media-libs/cubeb:=
	media-libs/libpng:=
	media-libs/libsfml
	media-libs/mesa[egl(+)]
	net-libs/enet:1.3
	net-libs/mbedtls:=
	net-misc/curl:=
	sys-libs/readline:=
	sys-libs/zlib:=[minizip]
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrandr
	virtual/libusb:1
	virtual/opengl
	alsa? ( media-libs/alsa-lib )
	bluetooth? ( net-wireless/bluez )
	evdev? (
		dev-libs/libevdev
		virtual/udev
	)
	ffmpeg? ( media-video/ffmpeg:= )
	gui? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
	profile? ( dev-util/oprofile )
	pulseaudio? ( media-sound/pulseaudio )
	systemd? ( sys-apps/systemd:0= )
	upnp? ( net-libs/miniupnpc )
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND+=" vulkan? ( media-libs/vulkan-loader ) "

# [directory]=license
declare -A KEEP_BUNDLED=(
	# please keep this list in CMakeLists.txt order

	[Bochs_disasm]=LGPL-2.1+
	[cpp-optparse]=MIT
	[imgui]=MIT
	[glslang]=BSD

	# FIXME: xxhash can't be found by cmake
	[xxhash]=BSD-2

	# FIXME: requires minizip-ng
	#[minizip]=ZLIB

	[FreeSurround]=GPL-2+
	[soundtouch]=LGPL-2.1+

	[picojson]=BSD-2
	[rangeset]=ZLIB
	[gtest]= # (build-time only)
)

src_prepare() {
	cmake_src_prepare

	local s remove=()
	for s in Externals/*; do
		[[ -f ${s} ]] && continue
		if ! has "${s#Externals/}" "${!KEEP_BUNDLED[@]}"; then
			remove+=( "${s}" )
		fi
	done

	einfo "removing sources: ${remove[*]}"
	rm -r "${remove[@]}" || die

	# About 50% compile-time speedup
	if ! use vulkan; then
		sed -i -e '/Externals\/glslang/d' CMakeLists.txt || die
	fi

	# Allow regular minizip.
	sed -i -e '/minizip/s:>=2[.]0[.]0::' CMakeLists.txt || die

	# Remove dirty suffix: needed for netplay
	sed -i -e 's/--dirty/&=""/' CMakeLists.txt || die

	# Force Qt5 rather than automagic until support is properly handled here
	sed -i -e '/NAMES Qt6 COMP/d' Source/Core/DolphinQt/CMakeLists.txt || die
}


src_configure() {
	local mycmakeargs=(
		# Use ccache only when user did set FEATURES=ccache (or similar)
		# not when ccache binary is present in system (automagic).
		-DCCACHE_BIN=CCACHE_BIN-NOTFOUND
		-DENABLE_ALSA=$(usex alsa)
		-DENABLE_AUTOUPDATE=OFF
		-DENABLE_BLUEZ=$(usex bluetooth)
		-DENABLE_EVDEV=$(usex evdev)
		-DENCODE_FRAMEDUMPS=$(usex ffmpeg)
		-DENABLE_LLVM=OFF
		# just adds -flto, user can do that via flags
		-DENABLE_LTO=OFF
		-DUSE_MGBA=OFF
		-DENABLE_PULSEAUDIO=$(usex pulseaudio)
		-DENABLE_QT=$(usex gui)
		-DENABLE_SDL=OFF # not supported: #666558
		-DENABLE_VULKAN=$(usex vulkan)
		-DFASTLOG=$(usex log)
		-DOPROFILING=$(usex profile)
		-DUSE_DISCORD_PRESENCE=OFF
		-DUSE_SHARED_ENET=ON
		-DUSE_UPNP=$(usex upnp)

		# Undo cmake.eclass's defaults.
		# All dolphin's libraries are private
		# and rely on circular dependency resolution.
		-DBUILD_SHARED_LIBS=OFF

		# Avoid warning spam around unset variables.
		-Wno-dev
	)

	cmake_src_configure
}

src_test() {
	cmake_build_unittests
}

src_install() {
	cmake_src_install

	dodoc Readme.md
	if use doc; then
		dodoc -r docs/ActionReplay docs/DSP docs/WiiMote
	fi

	doicon -s 48 Data/dolphin-emu.png
	doicon -s scalable Data/dolphin-emu.svg
	doicon Data/dolphin-emu.svg
}

pkg_postinst() {
	# Add pax markings for hardened systems
	pax-mark -m "${EPREFIX}"/usr/games/bin/"${PN}"-emu
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}

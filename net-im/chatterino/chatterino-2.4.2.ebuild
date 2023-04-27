# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake optfeature xdg-utils

DESCRIPTION="Chat client for https://twitch.tv"
HOMEPAGE="https://chatterino.com/"
EGIT_REPO_URI="https://github.com/Chatterino/chatterino2.git"
EGIT_SUBMODULES=('*')
EGIT_COMMIT="c8204ef7e4d799c77d98a168be7a5986b1fc082d" # 2.4.2 commit

#S=${WORKDIR}/chatterino2-${PV}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
BDEPEND="dev-vcs/git
	dev-qt/qtsvg:5
	dev-qt/qtconcurrent:5
	dev-qt/linguist-tools:5
	dev-libs/boost"
RDEPEND="dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtmultimedia:5
	dev-qt/qtdbus:5
	dev-libs/openssl:="
DEPEND="${RDEPEND}"

src_prepare() {
	rmdir --ignore-fail-on-non-empty ./lib/*/ ./cmake/*/ || die
	ln -sr ../libcommuni-* ./lib/libcommuni || die
	ln -sr ../qtkeychain-* ./lib/qtkeychain || die
	ln -sr ../rapidjson-* ./lib/rapidjson || die
	ln -sr ../websocketpp-* ./lib/websocketpp || die
	ln -sr ../serialize-* ./lib/serialize || die
	ln -sr ../signals-* ./lib/signals || die
	ln -sr ../settings-* ./lib/settings || die
	ln -sr ../sanitizers-cmake-* ./cmake/sanitizers-cmake || die
	ln -sr ../magic_enum-* ./lib/magic_enum || die
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	mv "${D}"/usr/share/icons/hicolor/256x256/apps/{com.chatterino.,}chatterino.png || die
}

pkg_postinst() {
	xdg_icon_cache_update
	optfeature "for opening streams in a local video player" net-misc/streamlink
}

pkg_postrm() {
	xdg_icon_cache_update
}

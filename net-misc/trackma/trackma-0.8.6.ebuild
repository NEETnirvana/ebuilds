EAPI=8
KEYWORDS="amd64"
PYTHON_COMPAT=( python3_{7..12} )
DISTUTILS_USE_PEP517=poetry

inherit distutils-r1 desktop

DESCRIPTION="Open multi-site list manager for media tracking sites"
HOMEPAGE="https://github.com/z411/trackma"
SRC_URI="https://github.com/z411/trackma/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
IUSE="+ncurses cli gtk inotify qt5"
REQUIRED_USE="|| ( cli gtk ncurses qt5 )"

DEPEND="ncurses? ( dev-python/urwid[${PYTHON_USEDEP}] )
	gtk? (
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		dev-python/pycairo[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
	)
	qt5? (
		dev-python/PyQt5[${PYTHON_USEDEP},gui,widgets]
		dev-python/pillow[${PYTHON_USEDEP}]
	)"

RDEPEND="sys-process/lsof
	inotify? ( || ( dev-python/pyinotify ) )
	${DEPEND}"

distutils_enable_tests pytest

python_configure_all() {
	if ! use cli; then
		rm "${S}/${PN}/ui/cli.py" || die
	fi

	if ! use ncurses; then
		rm "${S}/${PN}/ui/curses.py" || die
	fi

	if ! use gtk; then
		rm -R "${S}/${PN}/ui/gtk" || die
	fi

	if ! use qt5; then
		rm -R "${S}/${PN}/ui/qt" || die
	fi
}

python_install_all() {
	distutils-r1_python_install_all
	newicon "${S}/${PN}/data/icon.png" "${PN}.png"
	use cli && make_desktop_entry "${PN}" "${PN^} (cli)" "${PN}" "Network" "Terminal=true"
	use ncurses && make_desktop_entry "${PN}-curses" "${PN^} (ncurses)" "${PN}" "Network" "Terminal=true"
	use gtk && make_desktop_entry "${PN}-gtk" "${PN^} (gtk3)" "${PN}" "Network" "StartupWMClass=${PN}-gtk3"
	use qt5 && make_desktop_entry "${PN}-qt" "${PN^} (qt5)" "${PN}" "Network" "StartupWMClass=${PN}-qt5"
}

python_test() {
	FORCE_COLOR=1 epytest
}

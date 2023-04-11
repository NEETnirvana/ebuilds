# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utility to allow streaming Wayland windows to X applications"
HOMEPAGE="https://invent.kde.org/system/xwaylandvideobridge"
SRC_URI="https://github.com/chaos/scrub/releases/download/2.6.1/scrub-2.6.1.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	kde-frameworks/kcoreaddons
	kde-frameworks/ki18n
	kde-frameworks/kwindowsystem
	kde-frameworks/knotifications
	kde-frameworks/kwidgetsaddons
	dev-qt/qtquickcontrols2
	dev-qt/qtdbus
	dev-qt/qtx11extras
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cmake

"

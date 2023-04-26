# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
KFMIN=5.98.8
QTMIN=5.15.0
inherit ecm gear.kde.org

DESCRIPTION="EPub Reader for mobile devices"
HOMEPAGE="https://invent.kde.org/graphics/arianna"
SRC_URI="https://invent.kde.org/graphics/arianna/-/archive/v1.0.1/arianna-v1.0.1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

BDEPEND=""
RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-qt/qtdeclarative-${QTMIN}:5[widgets]
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtmultimedia-${QTMIN}:5
	>=dev-qt/qtsql-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kconfigwidgets-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kcrash-${KFMIN}:5
	>=kde-frameworks/kfilemetadata-${KFMIN}:5[taglib]
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/kitemviews-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
"

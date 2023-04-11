# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A simple and easy to use mod manager for several games using Thunderstore"
HOMEPAGE="https://thunderstore.io/package/ebkr/r2modman/"
SRC_URI="https://github.com/chaos/scrub/releases/download/2.6.1/scrub-2.6.1.tar.gz"
SRC_URI="https://github.com/ebkr/r2modmanPlus/releases/download/v${PV}/r2modman-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-themes/hicolor-icon-theme
		sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND=""

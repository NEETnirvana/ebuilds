# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Decrypts PlayStation Vita pkg file and packages to zip archive"
HOMEPAGE="https://github.com/mmozeiko/pkg2zip"
SRC_URI="https://github.com/lusid1/pkg2zip/archive/refs/tags/2.3.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	emake PREFIX="${D}" install || die
}

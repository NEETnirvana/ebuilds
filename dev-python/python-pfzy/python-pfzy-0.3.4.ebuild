# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{10..11} pypy3 )
inherit distutils-r1

DESCRIPTION="Python port of the fzy fuzzy string matching algorithm"
HOMEPAGE="https://github.com/kazhala/pfzy"
SRC_URI="https://files.pythonhosted.org/packages/source/p/pfzy/pfzy-0.3.4.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
dev-python/setuptools
dev-lang/python
"

S="${WORKDIR}/pfzy-${PV}"

distutils_enable_tests setup.py

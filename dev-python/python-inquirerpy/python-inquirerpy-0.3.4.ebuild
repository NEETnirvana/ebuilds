# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( pypy3 python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Python port of inquirer.js (A collection of common interactive command-line user interfaces)"
HOMEPAGE="https://github.com/kazhala/InquirerPy"
SRC_URI="https://files.pythonhosted.org/packages/source/I/InquirerPy/InquirerPy-0.3.4.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
dev-python/python-pfzy
dev-python/prompt-toolkit
dev-python/poetry-core
dev-lang/python"


S="${WORKDIR}/InquirerPy-${PV}"

distutils_enable_tests setup.py

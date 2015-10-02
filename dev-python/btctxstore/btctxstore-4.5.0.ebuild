# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Library to read/write data to bitcoin transaction outputs"
HOMEPAGE="https://github.com/F483/${PN}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools"
RDEPEND="dev-python/six
	dev-python/ecdsa
	dev-python/pycoin"

src_install() {
	rm -rf "${S}"/tests || die
	distutils-r1_src_install
}

python_install () {
	rm -rf "${BUILD_DIR}"/lib/tests || die
	distutils-r1_python_install
}

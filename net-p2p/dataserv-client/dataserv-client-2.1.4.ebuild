# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Client for storing and auditing data (storj.io)"
HOMEPAGE="http://storj.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools"
RDEPEND="dev-python/RandomIO
	dev-python/partialhash
	dev-python/future
	dev-python/btctxstore
	dev-python/storjcore
	dev-python/psutil"

src_install() {
	rm -rf "${S}"/tests || die
	distutils-r1_src_install
}

python_install () {
	rm -rf "${BUILD_DIR}"/lib/tests || die
	distutils-r1_python_install
}

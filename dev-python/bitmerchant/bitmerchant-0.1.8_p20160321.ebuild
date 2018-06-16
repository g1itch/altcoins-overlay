# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Bitcoin merchant tools"
HOMEPAGE="https://github.com/sbuss/${PN}"
COMMIT="901de06489805c396a922f955eeef2da04734e3e"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/base58[${PYTHON_USEDEP}]
	dev-python/ecdsa[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]"

S="${WORKDIR}"/${PN}-${COMMIT}


src_install() {
	rm -rf "${S}"/tests || die
	distutils-r1_src_install
}

python_install () {
	rm -rf "${BUILD_DIR}"/lib/tests || die
	distutils-r1_python_install
}

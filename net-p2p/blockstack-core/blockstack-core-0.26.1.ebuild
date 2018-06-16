# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

SUFFIX="browser"
DESCRIPTION="Reference implementation of Blockstack"
HOMEPAGE="http://blockstack.org/"
SRC_URI="https://github.com/blockstack/${PN}/archive/v${PV}-${SUFFIX}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	dev-python/virtualchain[${PYTHON_USEDEP}]
	dev-python/keychain[${PYTHON_USEDEP}]
	dev-python/protocoin[${PYTHON_USEDEP}]
	dev-python/blockstack-profiles[${PYTHON_USEDEP}]
	dev-python/blockstack-zones[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/pystun[${PYTHON_USEDEP}]
	dev-python/keylib[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-2.5.1[${PYTHON_USEDEP}]
	>=dev-python/jsontokens-0.0.4[${PYTHON_USEDEP}]
	dev-python/scrypt[${PYTHON_USEDEP}]
	>=dev-python/jsonpointer-1.14[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/basicrpc[${PYTHON_USEDEP}]
	dev-python/boto[${PYTHON_USEDEP}]
	net-misc/dropbox[${PYTHON_USEDEP}]
	dev-python/pydrive[${PYTHON_USEDEP}]
	dev-python/onedrivesdk[${PYTHON_USEDEP}]
"

S="${WORKDIR}"/${P}-${SUFFIX}

src_install() {
	rm -rf "${S}"/tests || die
	distutils-r1_src_install
}

python_install () {
	rm -rf "${BUILD_DIR}"/lib/tests || die
	distutils-r1_python_install
}

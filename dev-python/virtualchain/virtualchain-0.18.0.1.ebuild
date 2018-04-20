# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Library for scanning blockchains and running Blockstack state engines"
HOMEPAGE="https://github.com/blockstack/virtualchain"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools"
RDEPEND="
	dev-python/protocoin[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-2.5.1[${PYTHON_USEDEP}]
	>=dev-python/cryptography-1.9[${PYTHON_USEDEP}]
	dev-python/ecdsa[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/keylib[${PYTHON_USEDEP}]"

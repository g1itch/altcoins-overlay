# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Cross-platform Python CFFI bindings for libsecp256k1"
HOMEPAGE="https://github.com/ofek/${PN}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/asn1crypto[${PYTHON_USEDEP}]
	dev-python/cffi[${PYTHON_USEDEP}]
	>=dev-libs/libsecp256k1-0.1_pre20181126[gmp,ecdh]"

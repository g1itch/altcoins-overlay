# Copyright 2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Sawtooth Signing Library"
HOMEPAGE="https://github.com/hyperledger/sawtooth-core"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}
	dev-python/secp256k1[${PYTHON_USEDEP}]
"

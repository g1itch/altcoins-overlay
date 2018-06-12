# Copyright 2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Sawtooth Python SDK"
HOMEPAGE="https://github.com/hyperledger/sawtooth-core"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}
	dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/sawtooth-signing[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
	dev-python/pyzmq[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"

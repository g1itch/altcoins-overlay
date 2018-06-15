# Copyright 2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

MY_PV=${PV/_/-}
DESCRIPTION="Distributed Public Key Infrastructure (PKI) protocol"
HOMEPAGE="https://remme.io/"
SRC_URI="https://github.com/Remmeauth/${PN}/archive/v${MY_PV}.tar.gz
	-> ${P}.tar.gz"


LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
	dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/sawtooth-sdk[${PYTHON_USEDEP}]
	dev-python/sawtooth-signing[${PYTHON_USEDEP}]
	dev-python/sawtooth-cli[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/connexion[${PYTHON_USEDEP}]
"

S="${WORKDIR}"/${PN}-${MY_PV}

# src_install () {
# 	distutils-r1_src_install
# 	dodoc README.md
# }

# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

MY_PN=${PN}-py
DESCRIPTION="Library for elliptic curve (ECDSA) private keys, public keys, and bitcoin addresses"
HOMEPAGE="http://blockstack.org/"
COMMIT="ddcc33a6b67cb4cb56ae0fca15743d629b84845d"
SRC_URI="https://github.com/blockstack/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools"
RDEPEND="
	dev-python/ecdsa[${PYTHON_USEDEP}]
	dev-python/utilitybelt[${PYTHON_USEDEP}]"

S="${WORKDIR}"/${MY_PN}-${COMMIT}

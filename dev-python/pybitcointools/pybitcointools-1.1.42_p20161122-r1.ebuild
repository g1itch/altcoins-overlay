# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Python library for Bitcoin signatures and transactions"
HOMEPAGE="https://github.com/vbuterin/${PN}"
COMMIT="a82b00686b51677b047098e8968074a783e054a1"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"

RDEPEND="!dev-python/bitcoinlib"

S="${WORKDIR}"/${PN}-${COMMIT}

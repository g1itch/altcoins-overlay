# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="A key system for hierarchical deterministic (HD / BIP32) keychains"
HOMEPAGE="https://github.com/blockstack"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/bitmerchant[${PYTHON_USEDEP}]
	dev-python/keylib[${PYTHON_USEDEP}]"

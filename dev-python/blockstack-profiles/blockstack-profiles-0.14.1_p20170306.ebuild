# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN=${PN}-py
DESCRIPTION="Blockstack profile creation and verification tools"
HOMEPAGE="http://blockstack.org/"
COMMIT="103783798df78cf0f007801e79ec6298f00b2817"
SRC_URI="https://github.com/blockstack-packages/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools"
RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	>=dev-python/warlock-1.3.0[${PYTHON_USEDEP}]
	dev-python/keylib[${PYTHON_USEDEP}]
	dev-python/jsontokens[${PYTHON_USEDEP}]
	dev-python/blockstack-zones[${PYTHON_USEDEP}]"

S="${WORKDIR}"/${MY_PN}-${COMMIT}

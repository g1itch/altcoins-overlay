# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN=${PN}-py
DESCRIPTION="Library for signing and decoding JSON Web Tokens"
HOMEPAGE="http://blockstack.org/"
COMMIT="1a4e71ed63456e8381b7d3fd566ce38e6ebfa7d3"
SRC_URI="https://github.com/blockstack-packages/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools"
RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/keylib[${PYTHON_USEDEP}]"

S="${WORKDIR}"/${MY_PN}-${COMMIT}

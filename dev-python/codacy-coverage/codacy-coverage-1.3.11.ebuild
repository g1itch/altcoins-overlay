# Copyright 2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 python{3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Python coverage reporter for Codacy"
HOMEPAGE="https://github.com/codacy/python-codacy-coverage"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

DEPEND="test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)"
RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"

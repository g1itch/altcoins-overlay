# Copyright 2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Validation of Swagger specifications"
HOMEPAGE="http://github.com/Yelp/swagger_spec_validator"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/httpretty[${PYTHON_USEDEP}] )"

RDEPEND="${DEPEND}
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
"

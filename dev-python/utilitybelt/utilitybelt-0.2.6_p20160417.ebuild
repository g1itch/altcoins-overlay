# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

MY_PN=python-${PN}
DESCRIPTION="Miscellaneous python utilities by Halfmoon Labs"
HOMEPAGE="http://blockstack.org/"
COMMIT="13d3502aa1a486c9d775ad2c551fb8e7e48b0d96"
SRC_URI="https://github.com/blockstack/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools"

S="${WORKDIR}"/${MY_PN}-${COMMIT}

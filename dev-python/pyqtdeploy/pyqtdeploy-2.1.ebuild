# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{3_5,3_6} )

inherit distutils-r1

DESCRIPTION="PyQt Application Deployment Tool"
HOMEPAGE="https://www.riverbankcomputing.com/software/${PN}/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools"
RDEPEND="dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-qt/qtchooser"

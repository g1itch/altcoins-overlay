# Copyright 2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

MY_PN="PyDrive"
DESCRIPTION="A wrapper library of google-api-python-client that simplifies many common Google Drive API tasks."
HOMEPAGE="https://github.com/gsuitedevs/PyDrive"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/oauth2client[${PYTHON_USEDEP}]"

S="${WORKDIR}"/${MY_PN}-${PV}

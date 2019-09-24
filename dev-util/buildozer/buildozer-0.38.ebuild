# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{5,6} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Generic Python packager for Android / iOS and Desktop"
HOMEPAGE="http://github.com/kivy/buildozer"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="
	dev-python/pexpect[${PYTHON_USEDEP}]
	dev-python/virtualenv[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]"

RDEPEND="
	${DEPEND}
	dev-vcs/git
	dev-python/cython
	dev-python/pip"

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils2

MY_PN=QtPy
DESCRIPTION="Abstraction layer for PyQt5/PySide"
HOMEPAGE="https://github.com/spyder-ide/qtpy"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="designer gui opengl svg testlib"

RRDEPEND="!dev-python/QtPy[python_targets_python2_7]"
RDEPEND="
	dev-python/PyQt5-python2[designer?,opengl?,svg?]
	gui? ( dev-python/PyQt5-python2[gui,widgets] )
	testlib? ( dev-python/PyQt5-python2[testlib] )
"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	default

	sed -i -e "s/from PyQt4.Qt import/raise ImportError #/" qtpy/__init__.py || die
	sed -i -e "s/from PySide import/raise ImportError #/" qtpy/__init__.py || die
	sed -i -e "s/from PySide2 import/raise ImportError #/" qtpy/__init__.py || die
}

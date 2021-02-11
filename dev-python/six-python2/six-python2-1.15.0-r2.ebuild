# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils2

MY_PN=six
MY_P=$MY_PN-$PV
DESCRIPTION="Python 2 and 3 compatibility library"
HOMEPAGE="https://github.com/benjaminp/six https://pypi.org/project/six/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv s390 sparc x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
RESTRICT="test"

S="${WORKDIR}/${MY_PN}-${PV}"

BDEPEND="
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
"

RDEPEND="
	!dev-python/six[python_targets_python2_7]
"

distutils_enable_sphinx documentation --no-autodoc

python_install_all() {
	distutils2_python_install_all
	rm -r ${D}/usr/share
}

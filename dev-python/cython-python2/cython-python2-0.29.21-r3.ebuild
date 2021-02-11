# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils2 toolchain-funcs elisp-common

MY_PN=cython
MY_P=$MY_PN-$PV

DESCRIPTION="A Python to C compiler"
HOMEPAGE="https://cython.org https://pypi.org/project/Cython/
	https://github.com/cython/cython"
SRC_URI="https://github.com/cython/cython/archive/${PV}.tar.gz -> ${MY_P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris ~x86-solaris"
IUSE="emacs"
RESTRICT="test"

RDEPEND="
	!dev-python/cython[python_targets_python2_7]
	emacs? ( >=app-editors/emacs-23.1:* )
"
BDEPEND="
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
	${RDEPEND}"

PATCHES=(
	"${FILESDIR}/cython-0.29.14-sphinx-update.patch"
)

S="${WORKDIR}/${MY_PN}-${PV}"

SITEFILE=50cython-gentoo.el

python_compile() {
	# Python gets confused when it is in sys.path before build.
	local -x PYTHONPATH=

	distutils2_python_compile
}

python_compile_all() {
	use emacs && elisp-compile Tools/cython-mode.el
}

python_test() {
	tc-export CC
	# https://github.com/cython/cython/issues/1911
	local -x CFLAGS="${CFLAGS} -fno-strict-overflow"
	"${PYTHON}" runtests.py -vv --work-dir "${BUILD_DIR}"/tests \
		|| die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( CHANGES.rst README.rst ToDo.txt USAGE.txt )
	distutils2_python_install_all

	if use emacs; then
		elisp-install ${PN} Tools/cython-mode.*
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
	rm -r ${D}/usr/share
	rm -r ${D}/usr/bin
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

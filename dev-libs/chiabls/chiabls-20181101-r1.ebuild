# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1 cmake-utils

MY_PN="bls-signatures"
DESCRIPTION="BLS signatures in C++, using the relic toolkit"
HOMEPAGE="https://github.com/codablock/${MY_PN}"
PYBIND11_COMMIT="f7bc18f528bb35cd06c93d0a58c17e6eea3fa68c"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz
https://github.com/pybind/pybind11/archive/${PYBIND11_COMMIT}.tar.gz -> pybind11-2.3.dev0.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="python"

DEPEND="python? ( dev-python/setuptools[${PYTHON_USEDEP}] )"

RDEPEND="dev-libs/gmp[static-libs]
	dev-libs/libsodium[static-libs]"

S="${WORKDIR}"/${MY_PN}-${PV}

src_prepare() {
	rmdir contrib/pybind11
	ln -s "${WORKDIR}"/pybind11-${PYBIND11_COMMIT} contrib/pybind11
	cmake-utils_src_prepare
}

src_install() {
	cmake-utils_src_install
	use python && distutils-r1_src_install
}

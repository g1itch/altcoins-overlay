# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit distutils-r1 cmake-utils

MY_PN="bls-signatures"
DESCRIPTION="BLS signatures in c++ (python bindings)"
HOMEPAGE="https://github.com/Chia-Network/${MY_PN}"
COMMIT="5401869ae1a6f0235094fdfc93c51208c80d3000"
PYBIND11_COMMIT="f7bc18f528bb35cd06c93d0a58c17e6eea3fa68c"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
https://github.com/pybind/pybind11/archive/${PYBIND11_COMMIT}.tar.gz -> pybind11-2.3.dev0.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="python"

DEPEND="python? ( dev-python/setuptools[${PYTHON_USEDEP}] )"

RDEPEND="dev-libs/gmp[static-libs]
	dev-libs/libsodium[static-libs]"

S="${WORKDIR}"/${MY_PN}-${COMMIT}

src_prepare() {
	rmdir contrib/pybind11
	ln -s "${WORKDIR}"/pybind11-${PYBIND11_COMMIT} contrib/pybind11
	cmake-utils_src_prepare
}

src_install() {
	cmake-utils_src_install
	use python && distutils-r1_src_install
}

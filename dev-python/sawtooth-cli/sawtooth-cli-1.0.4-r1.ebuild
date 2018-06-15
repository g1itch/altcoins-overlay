# Copyright 2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 versionator

DESCRIPTION="Sawtooth CLI"
HOMEPAGE="https://github.com/hyperledger/sawtooth-core"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="test"

DEPEND="sys-apps/sed
	dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}
	dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/sawtooth-signing[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"

S="${WORKDIR}"/${PN/cli/core}-${PV}/cli


src_prepare() {
	local PVM=$(get_major_version)

	epatch "${FILESDIR}"/${PVM}-version.patch
	sed -e "s:%VER%:${PV}dev1:g" -i setup.py || die

	default_src_prepare
}

# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BBR"
COIN_FAMILY="cryptonote"

inherit versionator altcoin cmake-utils

HOMEPAGE="http://boolberry.com/"
SRC_URI="https://github.com/clintar/${COIN_NAME}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64"
IUSE="upnp +wallet"

DEPEND+="dev-lang/python"

PVM=$(get_version_component_range 1-2)

PATCHES=(
	"${FILESDIR}"/${PVM}-no-build-miniupnpc.patch
)

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	local mycmakeargs=(
		-DBUILD_GUI=0
		-DTARGET=daemon
		-DMINIUPNPC=0
	)
	has test $FEATURES || cmake_comment_add_subdirectory tests
	cmake-utils_src_compile
}

src_install() {
	newbin ${BUILD_DIR}/src/boolbd ${PN}
	if use wallet; then
		newbin ${BUILD_DIR}/src/simplewallet ${COIN_NAME}_wallet
	fi
	altcoin_install_inf
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}

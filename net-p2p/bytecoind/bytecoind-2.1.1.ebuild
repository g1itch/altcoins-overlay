# Copyright 2016-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=6
COIN_SYMBOL="BCN"
COIN_FAMILY="cryptonote"

inherit versionator altcoin cmake-utils

COMMIT="35ca81cc77f77a0096c204d3a6ed266d47d990af"
HOMEPAGE="https://bytecoin.org/"
SRC_URI="https://github.com/amjuarez/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS=""
IUSE="+wallet"

DEPEND+="dev-lang/python"
# net-libs/miniupnpc
# dev-cpp/gtest
# dev-cpp/sparsehash

S="${WORKDIR}"/${COIN_NAME}-${COMMIT}

PVM=$(get_version_component_range 1-2)

PATCHES=(
	"${FILESDIR}"/${PVM}-iostream.patch
)

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	local target=Daemon
	use wallet && target=PaymentGateService
	has test $FEATURES || cmake_comment_add_subdirectory tests
	cmake-utils_src_compile $target
}

src_install() {
	if use wallet; then
		newbin ${BUILD_DIR}/src/walletd ${COIN_NAME}_walletd
	else
		dobin ${BUILD_DIR}/src/${PN}
	fi
	altcoin_install_inf
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}

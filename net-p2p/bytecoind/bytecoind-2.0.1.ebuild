# Copyright 2016-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="BCN"
COIN_FAMILY="cryptonote"

inherit cmake-utils altcoin

COMMIT="d56f1c51664d9868403480867e8e68df49993e1e"
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

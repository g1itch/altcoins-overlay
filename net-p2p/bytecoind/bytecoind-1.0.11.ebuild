# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="BCN"

inherit cmake-utils altcoin

COMMIT="2bb89fe2a338ffbb8a289b6721015e447bd06c14"
HOMEPAGE="https://bytecoin.org/"
SRC_URI="https://github.com/amjuarez/${COIN_NAME}/archive/${COMMIT}.zip -> ${P}.zip"

SLOT="0"
KEYWORDS="~x86 ~amd64"
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

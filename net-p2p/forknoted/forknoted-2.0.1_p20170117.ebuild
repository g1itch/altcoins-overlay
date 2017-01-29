# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_FAMILY="forknote"

inherit cmake-utils altcoin

DESCRIPTION="Multiple Cryptonote currencies daemon"
HOMEPAGE="http://forknote.net/"
COMMIT="55e78deed0084b91ccc7b884e4ab936a0110ca27"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS=""
IUSE="+wallet"

DEPEND+="dev-lang/python"
# net-libs/miniupnpc
# dev-cpp/gtest
# dev-cpp/sparsehash
# roksdb

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

	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}

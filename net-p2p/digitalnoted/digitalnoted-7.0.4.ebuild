# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="XDN"
COIN_FAMILY="cryptonote"
inherit altcoin versionator

HOMEPAGE="http://digitalnote.biz/"
SRC_URI="https://github.com/${COIN_NAME}${COIN_SYMBOL}/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS=""
IUSE="+wallet"
DEPEND+="dev-lang/python
	net-libs/miniupnpc"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	append-cppflags \
		-Wno-error=unused-const-variable \
		-Wno-error=format-truncation
	local mycmakeargs=(
		-DUPNP_STATIC=OFF
	)
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

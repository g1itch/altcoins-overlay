# Copyright 2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="XRY"
COIN_FAMILY="cryptonote"

inherit altcoin cmake-utils versionator

MY_PN=${COIN_NAME^}CLI
HOMEPAGE="https://xry.io/"
COMMIT="a10f24df5c885b1868fe73715affef929e56049f"
SRC_URI="https://github.com/Vetro7/${MY_PN}/archive/${COMMIT}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+wallet"

DEPEND+="dev-lang/python
	net-libs/miniupnpc"

S="${WORKDIR}"/${MY_PN}-${COMMIT}

PVM=$(get_version_component_range 1-2)

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	append-cppflags \
		-Wno-error=unused-const-variable \
		-Wno-error=format-truncation \
		-Wno-error=implicit-fallthrough
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

	ewarn 'This coin is probably dead since middle of 2018!'
	ewarn 'Use with caution!'
	ewarn 'Look at https://bitcointalk.org/index.php?topic=2046563.440'
}

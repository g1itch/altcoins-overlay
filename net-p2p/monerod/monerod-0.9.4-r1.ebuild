# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="XMR"

inherit cmake-utils altcoin

MY_PN="bit${COIN_NAME}"
HOMEPAGE="http://www.monero.cc/"
SRC_URI="https://github.com/${COIN_NAME}-project/${MY_PN}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc" # upnp? wallet?

# dev-db/lmdb?
# sys-libs/libunwind?
DEPEND+="dev-lang/python
	virtual/pkgconfig
	net-libs/miniupnpc
	net-dns/unbound
	doc? ( app-doc/doxygen )"

S="${WORKDIR}"/${MY_PN}-${PV}


src_configure() {
	local mycmakeargs=(
		-DUPNP_STATIC=OFF
		-DUNBOUND_STATIC=OFF
	)
	cmake-utils_src_configure
}

src_compile() {
	local mycmakeargs=() target=daemon
	use doc || mycmakeargs+=(-DBUILD_DOCUMENTATION=OFF)
	has test $FEATURES || mycmakeargs+=(-DBUILD_TESTS=OFF)
	cmake-utils_src_compile $target
}

src_install() {
	newbin ${BUILD_DIR}/bin/bitmonerod ${PN}
	altcoin_install_inf
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}

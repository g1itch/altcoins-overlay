# Copyright 2017-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit altcoin versionator

DESCRIPTION="Command-line JSON-RPC client for BlocknetDX crypto-currency"
HOMEPAGE="http://blocknet.co/"
SRC_URI="https://github.com/${COIN_NAME}DX/${MY_PN}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"/${COIN_NAME}-${PV}


src_prepare() {
		local PVM=$(get_version_component_range 1-2)
		epatch "${FILESDIR}"/${PVM}-missing-include.patch
		eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --disable-tests --disable-bench \
		  --disable-ccache \
		  --disable-static \
		  --without-daemon \
		  --without-libs \
		  --without-gui \
		  --with-utils
}

src_install() {
	dobin src/${PN}
}

# Copyright 2015-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="WDC"
COIN_RPC_PORT=11082

inherit altcoin versionator

MY_PN="${COIN_NAME^}Daemon"
COMMIT="5d2a462930919313409789204ff1f224a7198f46"
HOMEPAGE="http://worldcoin.global/"
SRC_URI="https://github.com/${COIN_NAME}Global/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MY_PN}-${COMMIT}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	mv Source src
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}

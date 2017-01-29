# Copyright 2015-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="WDC"
COIN_RPC_PORT=11082

inherit altcoin

MyPN="${COIN_NAME^}Daemon"
COMMIT="5d2a462930919313409789204ff1f224a7198f46"
HOMEPAGE="http://worldcoin.global/"
SRC_URI="https://github.com/${COIN_NAME}Global/${MyPN}/archive/${COMMIT}.zip -> ${P}.zip"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MyPN}-${COMMIT}

src_prepare() {
	mv Source src
	epatch "${FILESDIR}"/${PN}-0.8.6.2-sys_leveldb.patch
	epatch "${FILESDIR}"/${PN}-0.8.7-make_target.patch
	epatch "${FILESDIR}"/${PN}-0.8.7-miniupnpc.patch
	altcoin_src_prepare
}

# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="WDC"
COIN_RPC_PORT=11082

inherit altcoin

MY_PN="${COIN_NAME^}Daemon"
MY_PV="00.08.07-Little_Devil"
COMMIT="a1dca6f05e9d042ba0d5ebca09ee1a1ea6f2090a"
HOMEPAGE="http://worldcoin.global/"
SRC_URI="https://github.com/${COIN_NAME}Global/${MY_PN}/archive/${COMMIT}.zip -> ${P}.zip"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"
S="${WORKDIR}"/${MY_PN}-${COMMIT}

src_prepare() {
	mv Source src
	epatch "${FILESDIR}"/${PN}-0.8.6.2-sys_leveldb.patch
	epatch "${FILESDIR}"/${PN}-0.8.7-make_target.patch
	epatch "${FILESDIR}"/${PN}-0.8.7-miniupnpc.patch
	altcoin_src_prepare
}

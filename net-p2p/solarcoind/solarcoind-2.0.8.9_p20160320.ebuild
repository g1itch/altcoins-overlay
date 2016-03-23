# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit altcoin

MY_PN="solarcoin"
COMMIT="3800ad2a03289b4407d2f79efda805d4f62c9a57"
DESCRIPTION="Solarcoin crypto-currency p2p network daemon"
HOMEPAGE="http://solarcoin.org"
SRC_URI="https://github.com/onsightit/${MY_PN}/archive/${COMMIT}.zip -> ${P}.zip"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"
S="${WORKDIR}/${MY_PN}-${COMMIT}"


src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0.8-sys_leveldb.patch
	altcoin_src_prepare
}

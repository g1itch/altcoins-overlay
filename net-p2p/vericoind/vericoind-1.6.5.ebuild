# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="VRC"

inherit altcoin

HOMEPAGE="http://www.vericoin.info/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"


src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.6.4-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	altcoin_src_install
	local manpath=contrib/debian/manpages
	newman ${manpath}/novacoind.1 ${PN}.1
	newman ${manpath}/novacoin.conf.5 ${COIN_NAME}.conf.5
}

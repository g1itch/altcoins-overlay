# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="VTR"
MY_PN=vTorrentd

inherit versionator altcoin

MyPN="vTorrent-Client"
HOMEPAGE="https://bitcointalk.org/index.php?topic=889481.0"
SRC_URI="https://github.com/${COIN_NAME}/${MyPN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MyPN}-${PV}

src_prepare() {
	epatch "${FILESDIR}"/$(get_version_component_range 1-2)-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
	local manpath=contrib/debian/manpages
	newman ${manpath}/novacoind.1 ${PN}.1
	newman ${manpath}/novacoin.conf.5 ${COIN_NAME}.conf.5
}

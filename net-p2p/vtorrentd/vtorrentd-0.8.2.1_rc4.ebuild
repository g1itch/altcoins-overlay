# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="VTR"
MY_PN=vTorrentd
MY_PV=${PV^^}

inherit versionator altcoin

MyPN="vTorrent-Client"
HOMEPAGE="https://bitcointalk.org/index.php?topic=889481.0"
SRC_URI="https://github.com/${COIN_NAME}/${MyPN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MyPN}-${MY_PV}

src_prepare() {
	epatch "${FILESDIR}"/$(get_version_component_range 1-2)-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}

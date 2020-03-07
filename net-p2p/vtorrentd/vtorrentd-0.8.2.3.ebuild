# Copyright 2017-2020 Gentoo Authors
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
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-openssl_1.1.patch
	epatch "${FILESDIR}"/${PVM}-boost_1.70.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install

	ewarn 'This coin is probably dead since 2018!'
	ewarn 'Use with caution!'
	ewarn 'Look at https://bitcointalk.org/index.php?topic=889481.5320'
}

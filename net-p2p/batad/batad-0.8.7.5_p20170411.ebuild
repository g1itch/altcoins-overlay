# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="BTA"
MY_PN="BATAd"
MyPN="BATA-SOURCE"

inherit versionator altcoin

HOMEPAGE="http://www.bata.io/"
COMMIT="ccc2c255e4fa54712776bcfa257f7a8b9a34a75f"
SRC_URI="https://github.com/${COIN_SYMBOL}-${COIN_NAME}/${MyPN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MyPN}-${COMMIT}


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}

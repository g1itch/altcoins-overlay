# Copyright 2016-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BAY"

inherit altcoin versionator

MyPN="${COIN_NAME}-core"
HOMEPAGE="http://bitbay.market/"
SRC_URI="https://github.com/bitbaymarket/${MyPN}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+wallet examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MyPN}-${PV}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/2.0-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-boost_1.70.patch
	epatch "${FILESDIR}"/${PVM}-openssl_1.1.patch
	altcoin_src_prepare
}

# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="XDN"
MY_PN=DigitalNoted
inherit altcoin versionator

HOMEPAGE="http://digitalnote.biz/"
SRC_URI="https://github.com/${COIN_NAME}${COIN_SYMBOL}/${MY_PN:0:-1}-2/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp +wallet"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MY_PN:0:-1}-2-${PV}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc-1.9.patch
	epatch "${FILESDIR}"/${PVM}-boost_1.70.patch
	epatch "${FILESDIR}"/${PVM}-secp256k1_openssl-1.1.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}

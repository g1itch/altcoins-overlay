# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
COIN_SYMBOL="ORB"
MY_PV=${PV}-orb

inherit altcoin

HOMEPAGE="http://orbitcoin.org/"
SRC_URI="https://github.com/ghostlander/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME^}-${MY_PV}


src_prepare() {
	mv src/Makefile.linux src/makefile.unix
	epatch "${FILESDIR}"/${PV}-sys_leveldb.patch
	altcoin_src_prepare
	default
}

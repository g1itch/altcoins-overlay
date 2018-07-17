# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="ADC"

inherit altcoin

HOMEPAGE="http://www.audiocoin.eu/"
SRC_URI="https://github.com/aurovine/${COIN_NAME}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/AudioCoin-${PV}


src_prepare() {
	epatch "${FILESDIR}"/1.2-sys_leveldb.patch
	altcoin_src_prepare
}

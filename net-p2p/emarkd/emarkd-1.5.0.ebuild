# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="DEM"
MY_PN=eMarkd

inherit altcoin

HOMEPAGE="http://deutsche-emark.de/"
SRC_URI="https://github.com/${COIN_NAME}project/${COIN_NAME}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MY_PN:0:-1}-${PV}

src_prepare() {
	epatch "${FILESDIR}"/1.4-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}

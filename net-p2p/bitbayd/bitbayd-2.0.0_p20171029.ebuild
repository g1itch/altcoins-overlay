# Copyright 2016-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BAY"

inherit altcoin

HOMEPAGE="http://bitbay.market/"
COMMIT="3653539796e282c89a9587ca5c99d8358a2fda59"
SRC_URI="https://github.com/dzimbeck/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+wallet examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}/BitBay-${COMMIT}"

src_prepare() {
	epatch "${FILESDIR}"/1.2-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	altcoin_src_install
	local manpath=contrib/debian/manpages
	newman ${manpath}/blackcoind.1 ${PN}.1
	newman ${manpath}/blackcoin.conf.5 ${COIN_NAME}.conf.5
}

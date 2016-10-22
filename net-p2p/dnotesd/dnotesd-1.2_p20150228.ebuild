# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="NOTE"
MY_PN=DNotesd

inherit altcoin flag-o-matic

COMMIT="bf5c4399e2d20215f89bfe0dbd2793042549e245"
HOMEPAGE="http://dnotescoin.com/"
SRC_URI="https://github.com/${COIN_NAME}Coin/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

S="${WORKDIR}"/DNotes-${COMMIT}


src_prepare() {
	epatch "${FILESDIR}"/1.2-miniupnpc_1.9.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}

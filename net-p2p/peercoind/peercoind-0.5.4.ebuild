# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="PPC"
MY_PV="${PV}ppc"
MY_PN=ppcoind

inherit altcoin

HOMEPAGE="http://peercoin.net/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}

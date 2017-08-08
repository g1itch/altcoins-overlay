# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
COIN_SYMBOL="PPC"
MY_CN="peercoin"
MY_PV="${PV}ppc"

inherit altcoin

HOMEPAGE="http://peercoin.net/"
SRC_URI="https://github.com/${MY_CN}/${MY_CN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="LTB"

inherit altcoin

HOMEPAGE="http://litebar.co/"
SRC_URI="https://github.com/Crypto-Currency/${COIN_NAME}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

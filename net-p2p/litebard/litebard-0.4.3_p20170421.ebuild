# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="LTB"

inherit altcoin

HOMEPAGE="http://litebar.co/"
COMMIT="0fe3ff98a9fe9263bf0ac4643d7675cae13284eb"
SRC_URI="https://github.com/Crypto-Currency/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

S="${WORKDIR}"/${COIN_NAME}-${COMMIT}

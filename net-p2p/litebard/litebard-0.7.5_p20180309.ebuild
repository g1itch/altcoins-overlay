# Copyright 2017-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="LTB"

inherit altcoin

HOMEPAGE="http://litebar.co/"
COMMIT="f92da333054c915412bfdfa78fb7ba0c71f4d512"
SRC_URI="https://github.com/Crypto-Currency/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

S="${WORKDIR}"/${COIN_NAME}-${COMMIT}

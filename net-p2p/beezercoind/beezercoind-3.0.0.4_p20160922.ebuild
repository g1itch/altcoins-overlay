# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="BEEZ"

inherit versionator altcoin

MY_PN="BeezerCoin"
HOMEPAGE="http://scrypt.ispace.co.uk/beezercoin"
COMMIT="ba6eb17c74372907fcc5d89e5e8069b6d3e8985a"
SRC_URI="https://github.com/Marty19/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}/${MY_PN}-${COMMIT}"

src_prepare() {
	rm Makefile
}

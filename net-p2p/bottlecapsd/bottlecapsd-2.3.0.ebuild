# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="CAP"

inherit altcoin

HOMEPAGE="https://bitcointalk.org/index.php?topic=241445.0"
SRC_URI="https://github.com/Tranz5/${COIN_NAME}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

src_prepare() {
	epatch "${FILESDIR}"/2.2-miniupnpc_1.9.patch
	altcoin_src_prepare
}

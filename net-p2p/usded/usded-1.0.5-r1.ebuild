# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="USDE"

inherit altcoin

HOMEPAGE="http://www.usd-e.com/"
SRC_URI="https://github.com/testzcrypto/${COIN_NAME}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

S="${WORKDIR}/${COIN_NAME^^}-${PV}"

src_install() {
	altcoin_src_install
	ewarn 'This coin is probably dead since 2015!'
	ewarn 'Use with caution!'
	ewarn 'Look at https://bitcointalk.org/index.php?topic=410254.10040'
}

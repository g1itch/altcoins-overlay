# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit altcoin

MY_PN="ppcoin"

DESCRIPTION="Peercoin crypto-currency p2p network daemon"
HOMEPAGE="http://peercoin.net/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/${PV}.zip -> ${P}.zip"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"


S="${WORKDIR}/${MY_PN}-${PV}"

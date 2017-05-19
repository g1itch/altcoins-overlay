# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="BEEZ"

inherit versionator altcoin

MyPN="BeezerCoin"
HOMEPAGE="http://scrypt.ispace.co.uk/beezercoin"
COMMIT="ba6eb17c74372907fcc5d89e5e8069b6d3e8985a"
SRC_URI="https://github.com/Marty19/${MyPN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

S="${WORKDIR}/${MyPN}-${COMMIT}"


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-miniupnpc_include.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
}

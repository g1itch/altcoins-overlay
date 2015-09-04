# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
inherit eutils autotools flag-o-matic

MY_PV="1.1"
COMMIT="88d567d57ee02cd5beeebd8dca00b736cb362ce9"
DESCRIPTION="Multi-algo CPUMiner & Reference Cryptonote Miner (JSON-RPC 2.0)"
HOMEPAGE="https://github.com/tpruvot/${PN}"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${PN}-${COMMIT}"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}
	dev-libs/jansson
	dev-libs/openssl"

src_prepare() {
	replace-flags -O2 -O3
	replace-flags -march=i686 -march=native
	epatch "${FILESDIR}"/${PN}-${MY_PV}-curl-openssl.patch
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install
	newinitd ${FILESDIR}/cpuminer.initd cpuminer
}

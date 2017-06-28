# Copyright 2015-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="ANC"

inherit altcoin versionator

MY_PV=5e441d8
DESCRIPTION="Command-line JSON-RPC client for Anoncoin crypto-currency"
HOMEPAGE="https://anoncoin.net/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}"/${COIN_NAME}-${MY_PV}

src_configure() {
	econf --disable-tests \
		  --without-gui \
		  --without-daemon \
		  --without-libs \
		  --with-utils
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/anoncoind" ||
		newman contrib/debian/manpages/${COIN_NAME}d.1 ${PN}.1

	newbashcomp contrib/${COIN_NAME}d.bash-completion ${PN}
}

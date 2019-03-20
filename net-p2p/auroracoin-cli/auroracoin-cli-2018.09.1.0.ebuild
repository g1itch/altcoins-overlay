# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for ${COIN_NAME^} crypto-currency"
HOMEPAGE="http://auroracoin.is/"
SRC_URI="https://github.com/aurarad/${COIN_NAME}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}"/${COIN_NAME^}-${PV}


src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --disable-tests \
		  --without-daemon \
		  --without-gui \
		  --with-cli
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/auroracoind" ||
		newman debian/manpages/auroracoind.1 ${PN}.1
}

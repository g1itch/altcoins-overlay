# Copyright 2017-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for ${COIN_NAME^} crypto-currency"
HOMEPAGE="http://www.vericoin.info/veriumlaunch.html"
SRC_URI="https://github.com/VeriumReserve/${COIN_NAME}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --without-gui \
		  --disable-tests \
		  --without-daemon \
		  --with-utils
}

src_install() {
	dobin src/${PN}

	doman doc/man/${PN}.1
	newbashcomp contrib/${PN}.bash-completion ${PN}
}

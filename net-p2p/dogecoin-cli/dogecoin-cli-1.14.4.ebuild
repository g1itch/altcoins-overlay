# Copyright 2018-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for ${COIN_NAME^} crypto-currency"
HOMEPAGE="http://dogecoin.com/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}"/${COIN_NAME}-${PV}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --disable-tests --disable-bench \
		  --without-daemon \
		  --without-libs \
		  --without-gui \
		  --with-utils
}

src_install() {
	dobin src/${PN}

	doman doc/man/${PN}.1
	newbashcomp contrib/${PN}.bash-completion ${PN}
}

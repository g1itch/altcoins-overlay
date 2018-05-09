# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="MEC"

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for BitSend crypto-currency"
HOMEPAGE="http://www.megacoin.eu/"
SRC_URI="https://github.com/LIMXTEC/${COIN_NAME}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}"/${COIN_NAME^}-${PV}


src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf \
		--disable-ccache \
		--disable-static \
		--disable-tests \
		--disable-bench \
		--with-system-univalue \
		--without-gui \
		--without-libs \
		--without-daemon \
		--with-utils
}

src_install() {
	dobin src/${PN}

	newman doc/man/${PN}.1 ${PN}.1
	newbashcomp contrib/${PN}.bash-completion ${PN}
}

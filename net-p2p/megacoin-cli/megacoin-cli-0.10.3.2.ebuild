# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="MEC"

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for BitSend crypto-currency"
HOMEPAGE="http://www.megacoin.co.nz"
SRC_URI="https://github.com/LIMXTEC/${COIN_NAME}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}"/${COIN_NAME^}-${PV}

src_configure() {
	econf --without-gui \
		  --disable-tests \
		  --without-libs \
		  --without-daemon \
		  --with-utils
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/${COIN_NAME}d" ||
		newman contrib/debian/manpages/bitcoind.1 ${PN}.1

	newbashcomp contrib/bitcoind.bash-completion ${PN}
}

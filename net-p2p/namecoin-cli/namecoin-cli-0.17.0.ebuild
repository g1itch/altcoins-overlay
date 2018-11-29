# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit altcoin

MY_PN=${COIN_NAME}-core
MY_PV=nc${PV/_/}
DESCRIPTION="Command-line JSON-RPC client for Namecoin crypto-currency"
HOMEPAGE="http://namecoin.info/"
SRC_URI="https://github.com/${COIN_NAME}/${MY_PN}/archive/${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}"/${MY_PN}-${MY_PV}


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

	newman doc/man/bitcoin-cli.1 ${PN}.1
	newbashcomp contrib/bitcoind.bash-completion ${PN}
}

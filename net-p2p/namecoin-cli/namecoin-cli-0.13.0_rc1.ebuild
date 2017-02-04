# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

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
	# To avoid executable GNU stack.
	append-ldflags -Wl,-z,noexecstack
	econf \
		--disable-ccache \
		--disable-static \
		--disable-tests \
		--with-system-leveldb \
		--with-system-univalue \
		--with-system-libsecp256k1 \
		--without-gui \
		--without-libs \
		--without-daemon \
		--with-utils
}

src_install() {
	dobin src/${PN}

	newman contrib/debian/manpages/bitcoin-cli.1 ${PN}.1
	newbashcomp contrib/bitcoind.bash-completion ${PN}
}

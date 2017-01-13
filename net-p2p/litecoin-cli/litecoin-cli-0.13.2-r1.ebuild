# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
COIN_NEEDS_SSL=0

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for Litecoin crypto-currency"
HOMEPAGE="https://litecoin.org/"
SRC_URI="https://github.com/${COIN_NAME}-project/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"


src_prepare() {
	rm -r src/leveldb
	epatch "${FILESDIR}"/${PV}-sys_leveldb.patch
	eautoreconf
}

src_configure() {
	# To avoid executable GNU stack.
	append-ldflags -Wl,-z,noexecstack
	econf \
		--disable-ccache \
		--disable-static \
		--disable-tests \
		--with-system-leveldb \
		--with-system-libsecp256k1  \
		--without-libs \
		--without-daemon  \
		--without-gui     \
		--without-qrencode \
		--with-utils
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/litecoind" ||
		newman contrib/debian/manpages/${COIN_NAME}d.1 ${PN}.1

	newbashcomp contrib/bitcoin-cli.bash-completion ${PN}
}

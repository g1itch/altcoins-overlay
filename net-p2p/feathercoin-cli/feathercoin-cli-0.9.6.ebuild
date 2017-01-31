# Copyright 2016-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit altcoin versionator

DESCRIPTION="Command-line JSON-RPC client for Feathercoin crypto-currency"
HOMEPAGE="http://feathercoin.com/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND+="dev-lang/yasm"

S="${WORKDIR}"/${COIN_NAME^}-${PV}

src_prepare() {
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --with-gui=no \
		  --without-qrcode \
		  --disable-tests \
		  --without-daemon \
		  --with-cli
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/${COIN_NAME}d" ||
		newman contrib/debian/manpages/${COIN_NAME}d.1 ${PN}.1

	newbashcomp contrib/${COIN_NAME}d.bash-completion ${PN}
}

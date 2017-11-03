# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="DGC"

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for ${COIN_NAME^} crypto-currency"
HOMEPAGE="https://bitcointalk.org/index.php?topic=785601.0"
COMMIT=77502c56b661a1b2aa9bd426431c5f138f676ead
SRC_URI="https://github.com/arthearts/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND+="dev-lang/yasm"

S="${WORKDIR}"/${COIN_NAME}-${COMMIT}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --without-gui \
		  --disable-tests \
		  --without-daemon \
		  --with-cli
}

src_install() {
	dobin src/${PN}
}

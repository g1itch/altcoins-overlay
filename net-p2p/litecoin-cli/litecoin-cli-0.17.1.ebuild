# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_NEEDS_SSL=0
MY_PV=${PV/_/}

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for Litecoin crypto-currency"
HOMEPAGE="https://litecoin.org/"
SRC_URI="https://github.com/${COIN_NAME}-project/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${MY_PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"


src_configure() {
	# To avoid executable GNU stack.
	append-ldflags -Wl,-z,noexecstack
	econf \
		--disable-ccache \
		--disable-static \
		--disable-tests \
		--with-system-univalue \
		--without-gui \
		--without-libs \
		--without-daemon \
		--with-utils
}

src_install() {
	dobin src/${PN}

	newman doc/man/litecoin-cli.1 ${PN}.1
	newbashcomp contrib/bitcoin-cli.bash-completion ${PN}
}

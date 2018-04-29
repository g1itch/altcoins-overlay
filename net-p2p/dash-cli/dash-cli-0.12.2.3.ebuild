# Copyright 2015-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for Dash crypto-currency"
HOMEPAGE="https://www.dashpay.io/"
SRC_URI="https://github.com/dashpay/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"

src_configure() {
	# To avoid executable GNU stack.
	append-ldflags -Wl,-z,noexecstack
	econf \
		--disable-ccache \
		--disable-static \
		--disable-tests \
		--disable-bench \
		--without-gui \
		--without-daemon \
		--without-libs \
		--with-utils
}

src_install() {
	dobin src/${PN}

	doman contrib/debian/manpages/${PN}.1
	newbashcomp contrib/${COIN_NAME}d.bash-completion ${PN}
}

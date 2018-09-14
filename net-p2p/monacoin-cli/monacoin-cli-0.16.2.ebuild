# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_NEEDS_SSL=0

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for Monacoin crypto-currency"
HOMEPAGE="https://monacoin.org/"
SRC_URI="https://github.com/${COIN_NAME}project/${COIN_NAME}/archive/${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}"/${COIN_NAME}-${COIN_NAME}-${PV}

src_configure() {
	# To avoid executable GNU stack.
	append-ldflags -Wl,-z,noexecstack
	econf \
		--disable-ccache \
		--disable-static \
		--disable-tests \
		--disable-bench \
		--with-system-leveldb \
		--with-system-univalue \
		--without-gui \
		--without-libs \
		--without-daemon \
		--with-utils
}

src_install() {
	dobin src/${PN}

	newbashcomp contrib/bitcoin-cli.bash-completion ${PN}
}

# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator altcoin

DESCRIPTION="Command-line JSON-RPC client for Solarcoin crypto-currency"
HOMEPAGE="http://solarcoin.org"
MY_PV=$(get_version_component_range 1-2)
SRC_URI="https://github.com/onsightit/${COIN_NAME}/archive/${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}"/${COIN_NAME}-${MY_PV}


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

# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit altcoin

MY_PN=${COIN_NAME}-core
MY_PV=nc${PV/_/}
DESCRIPTION="Command-line JSON-RPC client for Namecoin crypto-currency"
HOMEPAGE="http://namecoin.info/"
COMMIT="6bd97b16d2302e3673e8333dfd9c1935e7a48ff9"
SRC_URI="https://github.com/${COIN_NAME}/${MY_PN}/archive/${COMMIT}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}"/${MY_PN}-${COMMIT}


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
		--with-system-libsecp256k1 \
		--without-gui \
		--without-libs \
		--without-daemon \
		--with-utils
}

src_install() {
	dobin src/${PN}

	newbashcomp contrib/bitcoin-cli.bash-completion ${PN}
}

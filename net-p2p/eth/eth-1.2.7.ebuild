# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_NAME="ethereum"
COIN_SYMBOL="ETH"
COIN_RPC_PORT=8545

inherit git-r3 altcoin cmake-utils

MY_PN="webthree-umbrella"
HOMEPAGE="https://www.ethereum.org/"
EGIT_REPO_URI="git://github.com/${COIN_NAME}/${MY_PN}.git"
EGIT_COMMIT="v${PV}"

LICENSE="MIT ISC GPL-3 LGPL-2.1 public-domain || ( CC-BY-SA-3.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp"

S="${WORKDIR}"/${P}

# layman -a lmiphay for dev-db/rocksdb
# dev-db/rocksdb
# layman -a OSSDL for dev-lang/v8
# dev-lang/v8
DEPEND+="
	>=dev-util/cmake-3.0.0
	dev-libs/crypto++
	dev-libs/jsoncpp
	dev-cpp/libjson-rpc-cpp
	virtual/bitcoin-leveldb
	dev-libs/gmp
	net-misc/curl
	net-libs/libmicrohttpd"

RDEPEND+="
	dev-libs/libnatspec
	app-crypt/libscrypt"


src_configure() {
	# -DEVMJIT sys-devel/llvm?
	local mycmakeargs=(
		-DGUI=0
		-DSOLIDITY=0
		-DETHASHCL=0
		-DTOOLS=0
	)
	use upnp || mycmakeargs+=(-DMINIUPNPC=0)
	has test $FEATURES || mycmakeargs+=(-DTESTS=0)
	# cmake_comment_add_subdirectory libnatspec
	# cmake_comment_add_subdirectory libscrypt
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	rm "${D}"usr/lib/libscrypt.so "${D}"usr/lib/libnatspec.so
	altcoin_install_inf
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}

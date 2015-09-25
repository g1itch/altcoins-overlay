# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit cmake-utils flag-o-matic

DESCRIPTION="Ethereum miner"
HOMEPAGE="https://www.ethereum.org"

if [[ ${PV} = *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/ethereum/cpp-ethereum.git"
	KEYWORDS=""
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT ISC GPL-3 LGPL-2.1 public-domain || ( CC-BY-SA-3.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS=""

# layman -a lmiphay for dev-db/rocksdb
# dev-db/rocksdb
# layman -a OSSDL for dev-lang/v8
# dev-lang/v8
# dev-cpp/libjson-rpc-cpp
# virtual/opencl
RDEPEND="
	>=dev-libs/boost-1.53.0[threads(+)]
	>=dev-libs/crypto++-5.6.2
	dev-libs/gmp
	dev-libs/jsoncpp
	net-libs/miniupnpc
	net-misc/curl
	virtual/bitcoin-leveldb
	app-crypt/libscrypt
"

DEPEND="${RDEPEND}"


src_prepare() {
	epatch "${FILESDIR}"/${PN}-libs.patch
}

src_configure() {
	append-flags -Wno-error -Wno-return-type
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DBUNDLE=miner
	)

	cmake-utils_src_configure
}

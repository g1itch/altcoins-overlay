# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4} )

inherit cmake-utils python-single-r1

DESCRIPTION="Open Transactions - Libraries and CLI"
HOMEPAGE="http://opentransactions.org/"

CHAISCRIPT_COMMIT="e7b6ee6cf9e795d968b375244895589d4c6fc6c4"
LUCRE_COMMIT="2d61103b77813da1bbc8a8e0b6a12dadaf86af9a"
SIMPLEINI_COMMIT="fa2f4ebceeb4c4cb67d9a020b6d94f02baad66c6"
TREZOR_CRYPTO_COMMIT="20bb7e9b5c932c6afe112630a615f5cc74c6c056"
SRC_URI="https://github.com/Open-Transactions/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
https://github.com/ChaiScript/ChaiScript/archive/${CHAISCRIPT_COMMIT}.tar.gz -> ChaiScript-${CHAISCRIPT_COMMIT}.tar.gz
https://github.com/Open-Transactions/lucre/archive/${LUCRE_COMMIT}.tar.gz -> lucre-${LUCRE_COMMIT}.tar.gz
https://github.com/brofield/simpleini/archive/${SIMPLEINI_COMMIT}.tar.gz -> simpleini-${SIMPLEINI_COMMIT}.tar.gz
https://github.com/trezor/trezor-crypto/archive/${TREZOR_CRYPTO_COMMIT}.tar.gz -> trezor-crypto-${TREZOR_CRYPTO_COMMIT}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc python +openssl +dht fs sqlite rsa test"
# keyring support is broken
# gnome-keyring kwallet

RDEPEND=""
DEPEND="net-p2p/opentxs-proto
	>=dev-libs/protobuf-2.6
	dev-libs/libsecp256k1
	dev-libs/libsodium
	>=net-libs/czmq-4
	doc? ( app-doc/doxygen )
	python? ( ${PYTHON_DEPS} >=dev-lang/swig-3 )
	openssl? ( >=dev-libs/openssl-1.0.1 )
	fs? ( dev-libs/boost )
	sqlite? ( dev-db/sqlite )
	test? ( dev-cpp/gtest )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

PVM=$(get_version_component_range 1-2)
PATCHES=(
	"${FILESDIR}"/${PVM}-version.patch
)

src_prepare() {
	rmdir deps/gtest
	mv ../ChaiScript-${CHAISCRIPT_COMMIT}/* deps/ChaiScript
	mv ../lucre-${LUCRE_COMMIT}/* deps/lucre
	mv ../simpleini-${SIMPLEINI_COMMIT}/* deps/simpleini
	mv ../trezor-crypto-${TREZOR_CRYPTO_COMMIT}/* deps/trezor-crypto
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use python PYTHON)
		# $(cmake-utils_use gnome-keyring KEYRING_GNOME)
		# $(cmake-utils_use kwallet KEYRING_KWALLET)
		$(cmake-utils_use dht OT_DHT)
		$(cmake-utils_use fs OT_STORAGE_FS)
		$(cmake-utils_use sqlite OT_STORAGE_SQLITE)
		$(cmake-utils_use rsa OT_CRYPTO_SUPPORTED_KEY_RSA)
		$(cmake-utils_use_build doc DOCUMENTATION)
		$(cmake-utils_use_build test TESTS)
	)

	use test || cmake_comment_add_subdirectory tests
	pushd deps
	cmake_comment_add_subdirectory gtest
	popd

	use openssl || mycmakeargs+=(
			-DOT_CRYPTO_USING_OPENSSL=OFF
			-DOT_CRYPTO_SUPPORTED_ALGO_AES=OFF)

	append-cppflags -Wno-missing-field-initializers
	cmake-utils_src_configure
}

# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
inherit git-r3 eutils toolchain-funcs

DESCRIPTION="libsnark: a C++ library for zkSNARK proofs"
HOMEPAGE="http://www.scipr-lab.org/"
EGIT_COMMIT="8b422be264026b22ef5bae38655988f4a58dc410"
EGIT_REPO_URI="https://github.com/zcash/${PN}"

LICENSE="MIT"
SLOT="zcash"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/gmp[cxx]
	dev-lang/nasm
	sys-process/procps
	dev-libs/boost
	dev-libs/openssl
	dev-libs/libsodium"

src_prepare() {
	export CXXFLAGS="$CXXFLAGS -lsodium"

	OPTS=("CURVE=ALT_BN128" "NO_GTEST=1" "NO_SUPERCOP=1" "NO_DOCS=1")
	sed -i 's|$(PREFIX)/lib|$(PREFIX)/$(LIBDIR)|' Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" "${OPTS[@]}"
}

src_install() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" PREFIX="${D}/usr" \
		  LIBDIR=$(get_libdir) "${OPTS[@]}" install
}

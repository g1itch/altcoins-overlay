# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
inherit git-r3 eutils toolchain-funcs

DESCRIPTION="libsnark: a C++ library for zkSNARK proofs"
HOMEPAGE="http://www.scipr-lab.org/"
EGIT_COMMIT="746ade7ce0f30a6f6e612e50450294c8e7ade9a4"
EGIT_REPO_URI="https://github.com/scipr-lab/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/gmp[cxx]
	dev-lang/nasm
	sys-process/procps
	dev-libs/boost
	dev-libs/openssl"

src_prepare() {
	local XBYAK_GIT="git://github.com/herumi/xbyak.git" \
		  ATE_PAIRING_GIT="git://github.com/herumi/ate-pairing.git"
	mkdir depsrc
	git-r3_fetch ${XBYAK_GIT} refs/tags/v5.10
	git-r3_checkout ${XBYAK_GIT} ${S}/depsrc/xbyak
	git-r3_fetch ${ATE_PAIRING_GIT} refs/tags/v1.2
	git-r3_checkout ${ATE_PAIRING_GIT} ${S}/depsrc/ate-pairing
	cd depsrc/ate-pairing
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" CFLAGS="$CFLAGS -fPIC" \
		  -j SUPPORT_SNARK=1

	cd ../..
	mkdir depinst
	cp -rv depsrc/ate-pairing/include depinst/
	cp -rv depsrc/ate-pairing/lib depinst/

	OPTS=("NO_GTEST=1" "NO_SUPERCOP=1" "NO_DOCS=1")
	sed -i 's|$(PREFIX)/lib|$(PREFIX)/$(LIBDIR)|' Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" "${OPTS[@]}"
}

src_install() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" PREFIX="${D}/usr" \
		  LIBDIR=$(get_libdir) "${OPTS[@]}" install
}

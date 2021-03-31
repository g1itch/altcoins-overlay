# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="XVG"

inherit altcoin versionator

TOR_PV=0.3.4.9
TOR_PF=tor-$(replace_version_separator 4 - ${TOR_PV})

MyPN=${COIN_NAME^^}
HOMEPAGE="http://vergecurrency.com/"
SRC_URI="https://github.com/vergecurrency/${MyPN}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz
https://www.torproject.org/dist/${TOR_PF}.tar.gz"

SLOT="0"
KEYWORDS=""
IUSE="examples upnp +wallet cpu_flags_x86_sse2"

RDEPEND+=">=dev-libs/leveldb-1.18-r1"

S="${WORKDIR}"/${MyPN}-${PV}


src_prepare() {
	local PVM=$(get_major_version)
	rm -rf tor; mv ../${TOR_PF} tor
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-tor_zstd.patch
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	append-ldflags -lscrypt
	local my_econf=
	has test $FEATURES || my_econf="${my_econf} --disable-tests"
	econf \
		$(use_with upnp miniupnpc) \
		$(use_enable upnp upnp-default) \
		$(use_enable wallet) \
		$(use_enable cpu_flags_x86_sse2 sse2) \
		--disable-ccache \
		--disable-libscrypt \
		--with-system-leveldb \
		--without-gui \
		--with-daemon \
		${my_econf}
}

src_install() {
	mv src/${MyPN}d src/${PN}
	altcoin_src_install
}

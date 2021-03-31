# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="XVG"
COIN_BOOST_MAX=1.72
inherit altcoin versionator

TOR_PV=0.4.3.5
TOR_PF=tor-$(replace_version_separator 4 - ${TOR_PV})

MyPN=${COIN_NAME^^}
HOMEPAGE="http://vergecurrency.com/"
SRC_URI="https://github.com/vergecurrency/${MyPN}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz
https://www.torproject.org/dist/${TOR_PF}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet zeromq"

DEPEND+="dev-libs/univalue"
RDEPEND+=">=dev-libs/leveldb-1.18-r1"


src_prepare() {
	local PVM=$(get_major_version)
	rm -rf src/tor; mv ../${TOR_PF} src/tor
	epatch "${FILESDIR}"/5-sys_leveldb.patch
	epatch "${FILESDIR}"/5-secp256k1.patch
	epatch "${FILESDIR}"/${PVM}-tor_scrypt.patch
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	local my_econf=
	has test $FEATURES || my_econf="${my_econf} --disable-tests --disable-bench"
	econf \
		$(use_with upnp miniupnpc) \
		$(use_enable upnp upnp-default) \
		$(use_enable wallet) \
		$(use_enable zeromq zmq) \
		--disable-ccache \
		--disable-static \
		--with-system-leveldb \
		--with-system-univalue \
		--without-gui \
		--without-libs \
		--without-utils \
		--with-daemon \
		${my_econf}
}

src_install() {
	mv src/${MyPN}d src/${PN}
	altcoin_src_install
}

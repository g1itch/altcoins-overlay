# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BLOCK"
MY_PN="BlockDX"

inherit altcoin versionator

HOMEPAGE="http://blocknet.co/"
SRC_URI="https://github.com/${COIN_NAME}DX/${MY_PN}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples upnp +wallet zeromq libressl"

# --with-zerocoin-bignum=gmp|openssl|auto
RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	dev-libs/univalue
	zeromq? ( net-libs/zeromq )
"

S="${WORKDIR}"/${COIN_NAME}-${PV}


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	rm -r src/leveldb
	epatch "${FILESDIR}"/3.9-sys_leveldb.patch
	epatch "${FILESDIR}"/3.12-sys_univalue.patch
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	local my_econf=
	has test $FEATURES || \
		my_econf="${my_econf} --disable-tests --disable-bench"
	econf \
		$(use_with upnp miniupnpc) \
		$(use_with libressl unsupported-ssl) \
		$(use_enable upnp upnp-default) \
		$(use_enable wallet) \
		$(use_enable zeromq zmq) \
		--disable-ccache \
		--disable-static \
		--with-system-leveldb \
		--with-system-univalue \
		--with-system-libsecp256k1  \
		--without-utils \
		--without-libs \
		--without-gui \
		--with-daemon \
		${my_econf}
}

src_install() {
	mv src/${PN}xd src/${PN}
	altcoin_src_install
}

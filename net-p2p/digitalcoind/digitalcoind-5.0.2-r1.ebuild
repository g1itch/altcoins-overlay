# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="DGC"
COIN_FAMILY="DASH"

inherit versionator altcoin

HOMEPAGE="https://bitcointalk.org/index.php?topic=785601.0"
SRC_URI="https://github.com/lomtax/${COIN_NAME}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet zeromq"

RDEPEND+=">=dev-libs/leveldb-1.18-r1
	zeromq? ( net-libs/zeromq )"
DEPEND+="dev-lang/yasm"


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	rm -r src/leveldb
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-openssl_1.1.patch
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
		--without-utils \
		--without-libs \
		--without-gui \
		--with-daemon \
		${my_econf}
}

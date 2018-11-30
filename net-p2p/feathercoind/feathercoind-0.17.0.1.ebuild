# Copyright 2016-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="FTC"

inherit versionator altcoin

HOMEPAGE="http://feathercoin.com/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet zeromq"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	>=dev-libs/univalue-1.0.4
	zeromq? ( net-libs/zeromq )
"

S="${WORKDIR}"/${COIN_NAME^}-${PV}


src_prepare() {
	rm -r src/leveldb
	epatch "${FILESDIR}"/0.13-sys_leveldb.patch
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
		--without-utils \
		--without-libs \
		--without-gui \
		--with-daemon \
		${my_econf}
}

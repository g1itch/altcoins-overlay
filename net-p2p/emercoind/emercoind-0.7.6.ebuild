# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="EMC"
MY_PV="${PV}emc"

inherit versionator altcoin

HOMEPAGE="http://emercoin.com/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet zeromq"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	dev-libs/univalue
	zeromq? ( net-libs/zeromq )
"


src_prepare() {
	rm -r src/leveldb
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
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

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}

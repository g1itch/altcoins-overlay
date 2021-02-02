# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="NLG"

inherit versionator altcoin

MyPN="gulden-official"
HOMEPAGE="https://gulden.com/"
SRC_URI="https://github.com/Gulden/${MyPN}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~amd64"
IUSE="examples upnp +wallet zeromq"

DEPEND+=">=sys-devel/gcc-7.3 dev-libs/crypto++"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	dev-libs/univalue
	dev-libs/crypto++
	zeromq? ( net-libs/zeromq )
"

S="${WORKDIR}"/${MyPN}-${PV}


src_prepare() {
	rm -r src/leveldb
	epatch "${FILESDIR}"/2.1-sys_leveldb.patch
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

src_install() {
	mv src/GuldenD src/${PN}
	altcoin_src_install
}

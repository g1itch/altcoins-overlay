# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_NAME="feathercoin"
inherit altcoin gnome2-utils

DESCRIPTION="Qt wallet for ${COIN_NAME^} crypto-currency"
HOMEPAGE="http://feathercoin.com/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet zeromq qrcode"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	>=dev-libs/univalue-1.0.4
	qrcode? ( media-gfx/qrencode )
	zeromq? ( net-libs/zeromq )
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/linguist-tools:5
	!net-p2p/${COIN_NAME}d
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
		$(use_with qrcode qrencode) \
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
		--without-daemon \
		--with-gui \
		${my_econf}
}

src_install() {
	default
	make_desktop_entry "${PN} %u" "${COIN_NAME^}" "${COIN_NAME}" "Office;Finance"
	for size in {16,32,64,128,256}; do
		newicon -s ${size} share/pixmaps/bitcoin${size}.png ${COIN_NAME}.png
	done
}

pkg_preinst() {
		gnome2_icon_savelist
}

pkg_postinst() {
		gnome2_icon_cache_update
}

pkg_postrm() {
		gnome2_icon_cache_update
}

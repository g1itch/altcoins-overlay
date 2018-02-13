# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite,ipv6"

inherit eutils distutils-r1 gnome2-utils versionator

MY_PN="PyBitmessage"
DESCRIPTION="Reference client for Bitmessage: a P2P communications protocol"
HOMEPAGE="https://bitmessage.org"
SRC_URI="https://github.com/Bitmessage/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LINGUAS=( ar cs da de eo fr it ja nb nl no pl pt ru sk sv zh_cn )

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="ssl libressl qt4 ncurses opencl sound ${LINGUAS[@]/#/linguas_}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/msgpack[${PYTHON_USEDEP}]
	ssl? (
		!libressl? ( dev-libs/openssl:0[-bindist] )
		libressl? ( dev-libs/libressl )
	)
	qt4? ( dev-python/PyQt4[${PYTHON_USEDEP}] )
	ncurses? ( dev-python/pythondialog[${PYTHON_USEDEP}] )
	opencl? ( dev-python/numpy[${PYTHON_USEDEP}]
			  dev-python/pyopencl[${PYTHON_USEDEP}] )
	sound? ( || ( media-sound/gst123
				  media-sound/mpg123
				  media-sound/alsa-utils ) )"

S="${WORKDIR}"/${MY_PN}-${PV}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-desktop-network.patch
	epatch "${FILESDIR}"/${PV}-setup-fix.patch

	local lang
	for lang in ${LINGUAS[@]}; do
		use linguas_${lang} || \
			rm -f src/translations/bitmessage_${lang}.{ts,qm}
	done
}

src_install () {
	distutils-r1_src_install

	dodoc README.md
	doman man/*

	if use qt4; then
		newicon -s 24 desktop/icon24.png ${PN}.png
		newicon -s scalable desktop/can-icon.svg ${PN}.svg
		domenu desktop/${PN}.desktop
	fi
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

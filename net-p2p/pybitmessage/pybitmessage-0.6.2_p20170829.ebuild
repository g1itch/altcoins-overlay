# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1 gnome2-utils

MY_PN="PyBitmessage"

DESCRIPTION="Reference client for Bitmessage: a P2P communications protocol"
COMMIT="fc960cbf86d6f948e04d58ee10ed6f1c73233be2"
HOMEPAGE="https://bitmessage.org"
SRC_URI="https://github.com/Bitmessage/${MY_PN}/archive/${COMMIT}.tar.gz
	-> ${P}.tar.gz"

LINGUAS=( ar cs da de eo fr it ja nb nl no pl pt ru sk sv zh_cn )

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libressl +msgpack libnotify ncurses opencl qrcode qt4 sound ${LINGUAS[@]/#/linguas_}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"

RDEPEND="${DEPEND}
	msgpack? ( || ( dev-python/msgpack[${PYTHON_USEDEP}]
		 dev-python/u-msgpack[${PYTHON_USEDEP}] ) )
	!libressl? ( dev-libs/openssl:0[-bindist] )
	libressl? ( dev-libs/libressl )
	ncurses? ( dev-python/pythondialog[${PYTHON_USEDEP}] )
	opencl? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pyopencl[${PYTHON_USEDEP}]
	)
	qt4? ( dev-python/PyQt4[${PYTHON_USEDEP}] )
	sound? ( || ( media-sound/gst123
				  media-libs/gst-plugins-base:1.0
				  media-sound/mpg123
				  media-sound/alsa-utils ) )
	qrcode? ( dev-python/qrcode[${PYTHON_USEDEP}] )
	libnotify? ( dev-python/pygobject[${PYTHON_USEDEP}]
				 dev-python/notify2[${PYTHON_USEDEP}] )"

S="${WORKDIR}"/${MY_PN}-${COMMIT}

PATCHES=(
	"${FILESDIR}"/0.6-desktop-network.patch
	"${FILESDIR}"/0.6.3-ipv6.patch
	"${FILESDIR}"/0.6.3-notify.patch
)

src_prepare() {
	default_src_prepare

	local lang
	for lang in ${LINGUAS[@]}; do
		use linguas_${lang} || \
			rm -f src/translations/bitmessage_${lang}.{ts,qm}
	done
}

src_install () {
	distutils-r1_src_install
	dodoc README.md
	doman man/${PN}.1.gz

	# if use qt4; then
	# 	newicon -s 24 desktop/icon24.png ${PN}.png
	# 	newicon -s scalable desktop/can-icon.svg ${PN}.svg
	# 	domenu desktop/${PN}.desktop
	# fi
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

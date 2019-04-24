# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite,ssl,ipv6"

inherit distutils-r1 gnome2-utils versionator systemd

MY_PN="PyBitmessage"

DESCRIPTION="Reference client for Bitmessage: a P2P communications protocol"
COMMIT="38f36d7860d43b3b2feb60095d666c5e3ca56c80"
HOMEPAGE="https://bitmessage.org"
SRC_URI="https://github.com/Bitmessage/${MY_PN}/archive/${COMMIT}.tar.gz
	-> ${P}.tar.gz"

LINGUAS=( ar cs da de eo fr it ja nb nl no pl pt ru sk sv zh_cn )

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="daemon debug json libcanberra libnotify libressl +msgpack ncurses opencl qrcode qt5 sound systemd tor xml ${LINGUAS[@]/#/l10n_}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"

RDEPEND="${DEPEND}
	debug? ( dev-python/python-prctl[${PYTHON_USEDEP}] )
	!libressl? ( dev-libs/openssl:0[-bindist] )
	libressl? ( dev-libs/libressl )
	msgpack? ( || ( dev-python/msgpack[${PYTHON_USEDEP}]
		 dev-python/u-msgpack[${PYTHON_USEDEP}] ) )
	ncurses? ( dev-python/pythondialog[${PYTHON_USEDEP}] )
	opencl? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pyopencl[${PYTHON_USEDEP}] )
	qt5? ( || ( dev-python/QtPy[gui,${PYTHON_USEDEP}]
		   dev-python/PyQt5[widgets,network,${PYTHON_USEDEP}] ) )
	json? ( dev-python/jsonrpclib[${PYTHON_USEDEP}] )
	libcanberra? ( dev-python/pycanberra[${PYTHON_USEDEP}] )
	libnotify? ( dev-python/pygobject[${PYTHON_USEDEP}]
				 dev-python/notify2[${PYTHON_USEDEP}]
				 x11-themes/hicolor-icon-theme )
	qrcode? ( dev-python/qrcode[${PYTHON_USEDEP}] )
	sound? ( || ( dev-python/gst-python:1.0[${PYTHON_USEDEP}]
				  media-sound/gst123
				  media-libs/gst-plugins-base:1.0
				  media-sound/mpg123
				  media-sound/alsa-utils ) )
	tor? ( net-libs/stem[${PYTHON_USEDEP}] )
	xml? ( dev-python/defusedxml[${PYTHON_USEDEP}] )
"

S="${WORKDIR}"/${MY_PN}-${COMMIT}

PVM=$(get_version_component_range 1-3)
PATCHES=(
	"${FILESDIR}"/0.6-desktop-network.patch
	"${FILESDIR}"/${PVM}-knownnodes-validate.patch
	"${FILESDIR}"/${PVM}-api.patch
	"${FILESDIR}"/${PVM}-qt5.patch
)

src_prepare() {
	default_src_prepare

	local lang
	for lang in ${LINGUAS[@]}; do
		use l10n_${lang} || \
			rm -f src/translations/bitmessage_${lang}.{ts,qm}
	done
}

src_install () {
	distutils-r1_src_install
	dodoc README.md
	doman man/${PN}.1.gz

	if use daemon; then
		local DN="bitmessaged"
		newconfd "${FILESDIR}"/${DN}.confd  ${DN}
		newinitd "${FILESDIR}"/${DN}.initd ${DN}
		systemd_dounit packages/systemd/bitmessage.service
	fi
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

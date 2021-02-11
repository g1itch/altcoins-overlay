# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite,ssl"

inherit distutils2 gnome2-utils systemd

MY_PN="PyBitmessage"

DESCRIPTION="Reference client for Bitmessage: a P2P communications protocol"
HOMEPAGE="https://bitmessage.org"
SRC_URI="https://github.com/Bitmessage/${MY_PN}/archive/${PV}.tar.gz
	-> ${P}.tar.gz"

LINGUAS=( ar cs da de eo fr it ja nb nl no pl pt ru sk sv zh_cn )

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="daemon libressl +msgpack systemd libcanberra qt5 sound ${LINGUAS[@]/#/l10n_}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"

RDEPEND="${DEPEND}
	msgpack? ( dev-python/msgpack-python2 )
	!libressl? ( dev-libs/openssl:0[-bindist] )
	libressl? ( dev-libs/libressl )
	qt5? ( dev-python/QtPy-python2[gui]
		   dev-python/PyQt5-python2 )
	sound? ( || ( media-sound/gst123
				  media-libs/gst-plugins-base:1.0
				  media-sound/mpg123
				  media-sound/alsa-utils ) )
	libcanberra? ( dev-python/pycanberra-python2 )
"

S="${WORKDIR}"/${MY_PN}-${PV}

PATCHES=(
	"${FILESDIR}"/0.6-desktop-network.patch
	"${FILESDIR}"/${PV}-ipv6.patch
	"${FILESDIR}"/${PV}-qt5.patch
	"${FILESDIR}"/${PV}-maxobjectcount.patch
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
	distutils2_src_install
	dodoc README.md
	doman man/${PN}.1.gz

	if use daemon; then
		local DN="bitmessaged"
		newconfd "${FILESDIR}"/${DN}.confd  ${DN}
		newinitd "${FILESDIR}"/${DN}.initd ${DN}
		systemd_dounit packages/systemd/bitmessage.service
	fi

	insinto /etc/firejail
	doins "${FILESDIR}"/${PN}.profile
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

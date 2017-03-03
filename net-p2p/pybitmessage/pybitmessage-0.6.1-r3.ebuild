# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite,ipv6"

inherit eutils python-r1 gnome2-utils

MY_PN="PyBitmessage"
DESCRIPTION="Reference client for Bitmessage: a P2P communications protocol"
HOMEPAGE="https://bitmessage.org"
SRC_URI="https://github.com/Bitmessage/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LINGUAS=( ar cs da de eo fr it ja nb nl no pl pt ru sk sv zh_cn )

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl libressl qt4 ncurses menu opencl ${LINGUAS[@]/#/linguas_}"
REQUIRED_USE="${PYTHON_REQUIRED_USE} menu? ( qt4 )"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/msgpack[${PYTHON_USEDEP}]
	x11-misc/xdg-utils
	ssl? (
		!libressl? ( dev-libs/openssl:0[-bindist] )
		libressl? ( dev-libs/libressl )
	)
	qt4? ( dev-python/PyQt4[${PYTHON_USEDEP}] )
	ncurses? ( dev-python/pythondialog[${PYTHON_USEDEP}] )
	menu? ( dev-python/pygobject[${PYTHON_USEDEP}] )
	opencl? ( dev-python/numpy[${PYTHON_USEDEP}]
			  dev-python/pyopencl[${PYTHON_USEDEP}] )"

S="${WORKDIR}"/${MY_PN}-${PV}


src_compile() {
	cd src/bitmsghash/
	emake
}

src_install () {
	local lang
	for lang in ${LINGUAS[@]}; do
		use linguas_${lang} || \
			rm -f src/translations/bitmessage_${lang}.{ts,qm}
	done

	use qt4 || rm -rf src/bitmessageqt
	use ncurses || rm -rf src/bitmessagecurses
	touch src/__init__.py || die

	cat >> "${T}"/${PN}-wrapper <<-EOF || die
	#!/usr/bin/env python
	import os
	import sys
	sys.path.append("@SITEDIR@")
	os.chdir("@SITEDIR@")
	os.execl('@PYTHON@', '@EPYTHON@', '@SITEDIR@/bitmessagemain.py')
	EOF

	install_python() {
		python_moduleinto ${PN}
		python_domodule src/*
		sed \
			-e "s#@SITEDIR@#$(python_get_sitedir)/${PN}#" \
			-e "s#@EPYTHON@#${EPYTHON}#" \
			-e "s#@PYTHON@#${PYTHON}#" \
			"${T}"/${PN}-wrapper > ${PN} || die
		python_doscript ${PN}
	}

	python_foreach_impl install_python

	dodoc README.md debian/changelog
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

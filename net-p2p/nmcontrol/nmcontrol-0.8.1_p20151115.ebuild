# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
# PYTHON_REQ_USE="tk" # for splash screen

inherit eutils python-r1

DESCRIPTION="NMControl connects .bit domain lookups to the Namecoin client to allow for easy browsing of .bit domains."
HOMEPAGE="https://github.com/namecoin/${PN}"
COMMIT="49a879b98bb2885e3ba7c9fdf6dfe7e122e0edad"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="http networkmanager"

DEPEND="${PYTHON_DEPS}"
RDEPEND="
	net-p2p/namecoind
	http? ( dev-python/bottle[${PYTHON_USEDEP}] )
	networkmanager? ( net-misc/networkmanager )"

S="${WORKDIR}"/${PN}-${COMMIT}

src_compile() { :; }

src_install () {
	cat >> "${T}"/${PN}-wrapper <<-EOF || die
	#!/usr/bin/env python
	import os
	import sys
	sys.path.append("@SITEDIR@")
	os.chdir("@SITEDIR@")
	os.execl('@PYTHON@', '@APP@', '@SITEDIR@/nmcontrol.py', *sys.argv[1:])
	EOF

	install_python() {
		python_moduleinto ${PN}
		python_domodule {lib,plugin,service,${PN}.py}
		# python_domodule plugin
		# python_domodule service
		sed \
			-e "s#@SITEDIR@#$(python_get_sitedir)/${PN}#" \
			-e "s#@APP@#${PN}#" \
			-e "s#@PYTHON@#${PYTHON}#" \
			"${T}"/${PN}-wrapper > ${PN} || die
		python_doscript ${PN}
	}

	python_foreach_impl install_python
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	if use networkmanager; then
		exeinto /etc/NetworkManager/dispatcher.d/
		doexe ${FILESDIR}/nmcontrol-hook.sh
	fi
}

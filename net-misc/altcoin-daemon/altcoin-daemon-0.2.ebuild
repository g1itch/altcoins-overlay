# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit systemd

DESCRIPTION="Init scripts for altcoins"
HOMEPAGE="https://github.com/g1itch/altcoins-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="systemd logrotate"

RDEPEND="
	logrotate? (
		app-admin/logrotate
	)
"

S="${WORKDIR}"

src_install() {
	newconfd "${FILESDIR}"/${PN}.confd-r1 ${PN}
	newinitd "${FILESDIR}"/${PN}.initd-r1 ${PN}
	use systemd && systemd_dounit "${FILESDIR}"/${PN}.service
	# logrotate?
}

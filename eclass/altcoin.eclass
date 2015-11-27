# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
#
# @ECLASS: altcoin.eclass
# @MAINTAINER:
# Dmitri Bogomolov <4glitch@gmail.com>
# @BLURB: common code for altcoins ebuilds
# @DESCRIPTION:
# This eclass is used in ebuilds for altcoins (wallet daemons forked
# from bitcoin, litecoin etc)

DB_VER="4.8"
inherit autotools db-use eutils user

LICENSE="MIT"

RDEPEND="
	dev-libs/boost[threads(+)]
	dev-libs/openssl:0[-bindist]
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	net-misc/altcoin-daemon
"

DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
	sys-apps/sed
"

# @ECLASS-VARIABLE: COIN_NAME
# @DESCRIPTION:
# Set this variable before the inherit line
# if your coin or daemon have a nonstandard names

COIN_NAME=${COIN_NAME:-${PN:0:-1}}

altcoin_pkg_setup() {
	local UG="${COIN_NAME}"
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/${MY_PN} "${UG}"
}


altcoin_src_prepare() {
	if has_version '>=dev-libs/boost-1.52'; then
		sed -i 's/\(-l db_cxx\)/-l boost_chrono$(BOOST_LIB_SUFFIX) \1/' \
			src/makefile.unix
	fi
}


altcoin_src_test() {
	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		  -f makefile.unix "${OPTS[@]}" test || die 'Tests failed'
}


altcoin_src_install() {
	local UG="${COIN_NAME}" \
		  CONFIG_FILE=/etc/${COIN_NAME}/${COIN_NAME}.conf
	dobin src/${PN}

	dodir /etc/${COIN_NAME}
	echo "# http://www.bitcoin.org/smf/index.php?topic=644.0" > \
		 "${D}"${CONFIG_FILE}
	fowners ${UG}:${UG} ${CONFIG_FILE}
	fperms 600 ${CONFIG_FILE}

	dosym /etc/init.d/altcoin-daemon /etc/init.d/${PN}
	dodir /etc/conf.d
	echo "# Config file for ${PN} (look at /etc/conf.d/altcoin-daemon)" > \
		 "${D}"/etc/conf.d/${PN}
}


EXPORT_FUNCTIONS pkg_setup src_prepare src_test src_install

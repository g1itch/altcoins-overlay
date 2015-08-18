# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

DB_VER="4.8"

inherit db-use eutils systemd user git-2

MY_PN="potcoin"

DESCRIPTION="POTCOIN - A digital currency for the cannabis industry. POSv since 2015/08/01."
HOMEPAGE="http://www.potcoin.com/"
EGIT_REPO_URI="https://github.com/${MY_PN}/${MY_PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="examples ipv6 logrotate upnp"

RDEPEND="
	dev-libs/boost[threads(+)]
	dev-libs/openssl:0[-bindist]
	logrotate? (
		app-admin/logrotate
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
	sys-apps/sed
"


pkg_setup() {
	local UG="${MY_PN}"
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/${MY_PN} "${UG}"
}

src_prepare() {
	if has_version '>=dev-libs/boost-1.52'; then
		sed -i 's/\(-l db_cxx\)/-l boost_chrono$(BOOST_LIB_SUFFIX) \1/' src/makefile.unix
	fi
}

src_configure() {
	OPTS=()

	OPTS+=("DEBUGFLAGS=")
	OPTS+=("CXXFLAGS=${CXXFLAGS}")
	OPTS+=("LDFLAGS=${LDFLAGS}")

	if use upnp; then
		OPTS+=("USE_UPNP=1")
	else
		OPTS+=("USE_UPNP=-")
	fi

	use ipv6 || OPTS+=("USE_IPV6=-")

	OPTS+=("USE_SYSTEM_LEVELDB=1")
	OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
	OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" -f makefile.unix "${OPTS[@]}" ${PN}
}

#Tests are broken
#src_test() {
#	cd src || die
#	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" -f makefile.unix "${OPTS[@]}" test
#	./test_ppcoin || die 'Tests failed'
#}

src_install() {
	local UG="${MY_PN}"
	dobin src/${PN}

	insinto /etc/${MY_PN}
	doins "${FILESDIR}/${MY_PN}.conf"
	fowners ${UG}:${UG} /etc/${MY_PN}/${MY_PN}.conf
	fperms 600 /etc/${MY_PN}/${MY_PN}.conf

	newconfd "${FILESDIR}/${MY_PN}.confd" ${PN}
	newinitd "${FILESDIR}/${MY_PN}.initd" ${PN}
	systemd_dounit "${FILESDIR}/${MY_PN}.service"

	keepdir /var/lib/${MY_PN}/.${MY_PN}
	fperms 700 /var/lib/${MY_PN}
	fowners ${UG}:${UG} /var/lib/${MY_PN}/
	fowners ${UG}:${UG} /var/lib/${MY_PN}/.${MY_PN}
	dosym /etc/${MY_PN}/${MY_PN}.conf /var/lib/${MY_PN}/.${MY_PN}/${MY_PN}.conf

	dodoc README.md
	newman contrib/debian/manpages/bitcoind.1 ${PN}.1
	newman contrib/debian/manpages/bitcoin.conf.5 ${MY_PN}.conf.5

	if use examples; then
		docinto examples
		dodoc -r contrib/{bitrpc,gitian-descriptors,gitian-downloader,pyminer,wallettools}

	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/${PN}.logrotate" ${PN}
	fi
}

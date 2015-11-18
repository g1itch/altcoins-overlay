# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

DB_VER="4.8"

inherit bash-completion-r1 db-use eutils user flag-o-matic

MY_PN="megacoin"
DESCRIPTION="Megacoin crypto-currency p2p network daemon"
HOMEPAGE="http://www.megacoin.co.nz"
SRC_URI="mirror://sourceforge/${MY_PN}/files/${MY_PN}-${PV/g/G}-source.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND="
	dev-libs/boost[threads(+)]
	dev-libs/openssl:0[-bindist]
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	virtual/bitcoin-leveldb
	net-misc/altcoin-daemon
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
	sys-apps/sed
"

S="${WORKDIR}"

pkg_setup() {
	local UG="${MY_PN}"
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/${MY_PN} "${UG}"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-sys_leveldb.patch
	epatch "${FILESDIR}"/${P}-boost-replace_all.patch
	if has_version '>=dev-libs/boost-1.52'; then
		sed -i 's/\(-l db_cxx\)/-l boost_chrono$(BOOST_LIB_SUFFIX) \1/' \
			src/makefile.unix
	fi
}

src_configure() {
	append-flags -Wno-unused-local-typedefs
	OPTS=(
		"DEBUGFLAGS="
		"CXXFLAGS=${CXXFLAGS}"
		"LDFLAGS=${LDFLAGS}"
		"USE_SYSTEM_LEVELDB=1"
		"BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")"
		"BDB_LIB_SUFFIX=-${DB_VER}"
	)

	if use upnp; then
		OPTS+=("USE_UPNP=1")
	else
		OPTS+=("USE_UPNP=-")
	fi

	use ipv6 || OPTS+=("USE_IPV6=-")
	use cpu_flags_x86_sse2 && OPTS+=("USE_SSE2=1")

	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		  -f makefile.unix "${OPTS[@]}" ${PN}
}

src_test() {
	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		  -f makefile.unix "${OPTS[@]}" test || die 'Tests failed'
}

src_install() {
	local UG="${MY_PN}"
	dobin src/${PN}

	dodir /etc/${MY_PN}
	echo "# http://www.bitcoin.org/smf/index.php?topic=644.0" > \
		 "${D}"/etc/${MY_PN}/${MY_PN}.conf
	fowners ${UG}:${UG} /etc/${MY_PN}/${MY_PN}.conf
	fperms 600 /etc/${MY_PN}/${MY_PN}.conf

	dosym /etc/init.d/altcoin-daemon /etc/init.d/${PN}
	dodir /etc/conf.d
	echo "# Config file for ${PN} (look at /etc/conf.d/altcoin-daemon)" > \
		 "${D}"/etc/conf.d/${PN}

	dodoc README.md
	doman contrib/debian/manpages/${PN}.1
	doman contrib/debian/manpages/${MY_PN}.conf.5

	newbashcomp contrib/${PN}.bash-completion ${PN}

	if use examples; then
		docinto examples
		dodoc -r contrib/{megarpc,pyminer,wallettools}
	fi
}

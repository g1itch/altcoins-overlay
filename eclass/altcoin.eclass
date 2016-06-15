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
inherit autotools cmake-utils bash-completion-r1 db-use eutils user

LICENSE="MIT"

RDEPEND="
	dev-libs/boost[threads(+)]
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	net-misc/altcoin-daemon
"

if [[ $IUSE =~ libressl ]]; then
	RDEPEND+="!libressl? ( dev-libs/openssl:0[-bindist] )
			libressl? ( dev-libs/libressl )"
else
	RDEPEND+="dev-libs/openssl:0[-bindist]"
fi

[[ $IUSE =~ upnp ]] && RDEPEND+="upnp? ( net-libs/miniupnpc )"

DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
	sys-apps/sed
"

eshopts_push -s extglob

# @ECLASS-VARIABLE: COIN_NAME
# @DESCRIPTION:
# Set this variable before the inherit line
# if your coin or daemon have a nonstandard names

COIN_NAME=${COIN_NAME:-${PN%@(d|-cli)}}

# @ECLASS-VARIABLE: COIN_SYMBOL
# @DESCRIPTION:
# Set this variable before the inherit line
# to provide coin info

ISDAEMON=

DESCRIPTION=${DESCRIPTION:-"${COIN_NAME^} crypto-currency p2p network daemon"}

MY_PV=${MY_PV:-${PV}}

# not if git-r3!
S="${WORKDIR}"/${COIN_NAME}-${MY_PV}


altcoin_pkg_setup() {
	enewgroup blockchain 420
	enewuser blockchain 420 -1 -1 blockchain
}


altcoin_src_prepare() {
	if has_version '>=dev-libs/boost-1.52'; then
		sed -i 's/\(-l db_cxx\)/-l boost_chrono$(BOOST_LIB_SUFFIX) \1/' \
			src/makefile.unix
	fi
}


altcoin_src_configure() {
	OPTS=(
		"DEBUGFLAGS="
		"CXXFLAGS=${CXXFLAGS}"
		"LDFLAGS=${LDFLAGS}"
		"USE_SYSTEM_LEVELDB=1"
		"BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")"
		"BDB_LIB_SUFFIX=-${DB_VER}"
		"$@"
	)

	if use upnp; then
		OPTS+=("USE_UPNP=1")
	else
		OPTS+=("USE_UPNP=-")
	fi

	use ipv6 || OPTS+=("USE_IPV6=-")
	use cpu_flags_x86_sse2 && OPTS+=("USE_SSE2=1")
}


altcoin_src_compile() {
	[ -f Makefile ] && default_src_compile && return 0
	[ -f CMakeLists.txt ] && cmake-utils_src_compile && return 0
	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		  -f makefile.unix "${OPTS[@]}" ${PN}
}


altcoin_src_test() {
	[[ -f Makefile || -f CMakeLists.txt ]] && die 'Not implemented!'
	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		  -f makefile.unix "${OPTS[@]}" test || die 'Tests failed'
}


altcoin_install_inf() {
	# check monero and eth!
	dodir /etc/coins
	[ -z ${COIN_RPC_PORT} ] && COIN_RPC_PORT=`src/${PN} --help 2>&1 | grep -m1 rpcport | sed -ne "s/^.*default: \([0-9]*\)[ |)].*/\1/p"`
	echo '{"symbol": "'${COIN_SYMBOL}'", ' \
		 '"coin": "'${COIN_NAME}'", ' \
		 '"homepage": "'${HOMEPAGE}'", ' \
		 '"port": '${COIN_RPC_PORT}'}' > "${D}"etc/coins/${COIN_NAME}.inf
}

altcoin_src_install() {
	# masternode?
	local CONFIG_FILE=/etc/coins/${COIN_NAME}.conf
	dobin src/${PN}

	altcoin_install_inf

	echo "# http://www.bitcoin.org/smf/index.php?topic=644.0" > \
		 "${D}"${CONFIG_FILE}
	fowners blockchain:blockchain ${CONFIG_FILE}
	fperms 600 ${CONFIG_FILE}

	dosym /etc/init.d/altcoin-daemon /etc/init.d/${PN}
	dodir /etc/conf.d
	echo "# Config file for ${PN} (look at /etc/conf.d/altcoin-daemon)" > \
		 "${D}"/etc/conf.d/${PN}

	local bashcomp=contrib/${COIN_NAME}d.bash-completion
	[ -f $bashcomp ] && newbashcomp $bashcomp ${PN}

	for doc in {README,README.md}; do
		[ -f $doc ] && dodoc $doc
	done

	local manpath=contrib/debian/manpages
	for man in ${manpath}/{bitcoind,${PN}}.1; do
		[ -f $man ] && newman $man ${PN}.1
	done
	for man in ${manpath}/{bitcoin,${COIN_NAME}}.conf.5; do
		[ -f $man ] && newman $man ${COIN_NAME}.conf.5
	done

	if use examples; then
		docinto examples
		for ex in contrib/{bitrpc,pyminer,wallettools,linearize,qos,spendfrom}; do
			[ -d $ex ] dodoc -r $ex
		done
	fi
}

eshopts_pop

EXPORT_FUNCTIONS pkg_setup src_prepare src_configure src_compile src_test src_install

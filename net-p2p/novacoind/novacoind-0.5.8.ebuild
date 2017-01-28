# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="NVC"
inherit altcoin

MY_PV="nvc-v${PV}"
DESCRIPTION="Novacoin crypto-currency p2p network daemon"
HOMEPAGE="http://novacoin.org/"
SRC_URI="https://github.com/${COIN_NAME}-project/${COIN_NAME}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp" # no upnp!

# USE_LEVELDB:=0
# RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}/${COIN_NAME}-${MY_PV}"

# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="DMD"

inherit versionator altcoin

MY_PV=${COIN_NAME^}$(delete_all_version_separators)
HOMEPAGE="http://bit.diamonds/"
SRC_URI="https://github.com/${COIN_SYMBOL}coin/${COIN_NAME}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"

S="${WORKDIR}"/${COIN_NAME^}-${MY_PV}

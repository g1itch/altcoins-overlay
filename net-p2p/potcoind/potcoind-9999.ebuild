# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit altcoin git-2

MY_PN="potcoin"
DESCRIPTION="Potcoin crypto-currency p2p network daemon"
HOMEPAGE="http://www.potcoin.com/"
EGIT_REPO_URI="https://github.com/${MY_PN}/${MY_PN}.git"

SLOT="0"
KEYWORDS=""
IUSE="examples ipv6 upnp"

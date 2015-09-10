# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1 git-2

DESCRIPTION="Python wrapper for the miners RPC API"
HOMEPAGE="https://github.com/g1itch/${PN}"
EGIT_REPO_URI="https://github.com/g1itch/${PN}.git"

KEYWORDS=""
IUSE=""
LICENSE="MIT"
SLOT="0"

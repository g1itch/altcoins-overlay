# Copyright 2015-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1 git-2

DESCRIPTION="Python wrapper for the miners RPC API"
HOMEPAGE="https://github.com/g1itch/${PN}"
EGIT_REPO_URI="https://github.com/g1itch/${PN}.git"

KEYWORDS=""
IUSE=""
LICENSE="MIT"
SLOT="0"

# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="rust-snapshot-2018-05-22"
DESCRIPTION="A C library that may be linked into a C/C++ program to produce symbolic backtraces"
HOMEPAGE="https://github.com/rust-lang/${PN}"
SRC_URI="${HOMEPAGE}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~x86 ~amd64"
SLOT="0"

S="${WORKDIR}"/${PN}-${MY_PV}

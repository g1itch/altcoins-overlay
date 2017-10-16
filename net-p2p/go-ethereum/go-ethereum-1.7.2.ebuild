# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Official golang implementation of the Ethereum protocol"
HOMEPAGE="https://github.com/ethereum/${PN}"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="opencl" # evm?

DEPEND="dev-lang/go:=
	opencl? ( virtual/opencl )
"
RDEPEND="${DEPEND}"

src_compile() {
	use opencl && export GO_OPENCL=true

	emake geth
	# use evm && emake evm # oops, not working
}

src_install() {
	einstalldocs

	dobin build/bin/geth
	# use evm && dobin build/bin/evm
	newinitd "${FILESDIR}"/geth.initd geth
	newconfd "${FILESDIR}"/geth.confd geth
}

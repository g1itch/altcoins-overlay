# Copyright 2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils toolchain-funcs

DESCRIPTION="A TOR hidden service name generator"
HOMEPAGE="https://github.com/ReclaimYourPrivacy/eschalot"
COMMIT="56a967b62631cfd3c7ef68541263dbd54cbbc2c4"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/openssl"

S="${WORKDIR}"/${PN}-${COMMIT}

src_install() {
	mkdir -p "${D}"/usr/bin
	emake PREFIX="${D}/usr" install
}

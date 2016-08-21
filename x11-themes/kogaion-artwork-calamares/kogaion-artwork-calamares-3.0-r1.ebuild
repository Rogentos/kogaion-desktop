# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Kogaion Linux 3.0 branding component for Calamares"
HOMEPAGE="http://rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/distfiles/${CATEGORY}/${PN}/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="app-admin/calamares"

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/"adjust-calamares-urls.patch"
}

src_install() {
	dodir /etc/calamares/branding/kogaion_branding || die
	insinto /etc/calamares/branding/kogaion_branding || die
	doins -r "${S}"/* || die
}

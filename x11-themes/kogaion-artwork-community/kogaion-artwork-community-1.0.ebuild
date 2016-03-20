# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Kogaion Artwork Community"
HOMEPAGE="http://rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/distfiles/${CATEGORY}/${PN}/${PN}-${PV}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
S=${WORKDIR}/${PN}-${PV}

src_install() {
	dodir "/usr/share/backgrounds/kogaion-community" || die
	insinto "/usr/share/backgrounds/kogaion-community" || die
	doins -r "${S}"/* || die
}

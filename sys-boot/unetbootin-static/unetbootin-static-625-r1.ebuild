# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Universal Netboot Installer creates Live USB systems for various OS distributions"
HOMEPAGE="http://unetbootin.sourceforge.net"
SRC_URI="http://pkg.rogentos.ro/distfiles/${CATEGORY}/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-arch/p7zip
	media-libs/libpng:1.2"

src_install() {
	insopts -m 755
	dobin ${P}
	dobin ${FILESDIR}/${PN}-pkexec
	dodir /usr/share/applications
	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
	dodir /usr/share/polkit-1/actions
	insinto /usr/share/polkit-1/actions
	doins ${FILESDIR}/ro.kogaion.${PN}.policy
}

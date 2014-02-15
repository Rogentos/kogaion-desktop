# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker multilib versionator eutils

MY_G="gwan"

DESCRIPTION="G-Wan Analyzer"
HOMEPAGE="http://g-wan.ch/"
SRC_URI="http://${MY_G}.ch/archives/gwan_linux64-bit.tar.bz2
	http://${MY_G}.ch/archives/gwan_linux32-bit.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

RDEPEND="x11-libs/pango
	amd64? ( 
		app-emulation/emul-linux-x86-gtklibs 
		app-emulation/emul-linux-x86-baselibs	)"	
DEPEND=""

S="${WORKDIR}"

src_install() {
	cd "${S}" || die
	sh ./gwan || die
}

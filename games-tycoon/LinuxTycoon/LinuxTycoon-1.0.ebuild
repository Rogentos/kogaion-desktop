# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit unpacker multilib versionator eutils

MY_PN="LinuxTycoon"
MY_PV=$(replace_version_separator 2 '-')
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Lunduke made Linux Tycoon"
HOMEPAGE="http://lunduke.com/?page_id=2646"
SRC_URI="http://www.lunduke.com/linuxtycoon/${MY_PN}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

RESTRICT="fetch strip"

RDEPEND="x11-libs/pango
	media-libs/libpng:2
	x11-libs/pixman
	amd64? ( 
		app-emulation/emul-linux-x86-gtklibs 
		app-emulation/emul-linux-x86-baselibs	)"	
DEPEND=""

S="${WORKDIR}"

# Copyright 1999-2011 Sabayon Linux
# Copyright 2012 Rogentos Linux
# Distributed under the terms of the GNU General Public License v2
# $Header: $ 

EAPI=4
inherit multilib

DESCRIPTION="Rogentos LibreOffice Artwork"
HOMEPAGE="http://rogentos.ro/"
SRC_URI=".tar.gz"
LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-apps/sed"
RDEPEND=""

S=${WORKDIR}/${PN}

src_install () {
	cd "${S}/images"
	sed -i "s:650:620:" sofficerc || die
	insinto /usr/$(get_libdir)/libreoffice/program
        doins *.png sofficerc
}

pkg_postinst () {
	ewarn "Please report bugs or glitches to"
	ewarn "bugs.rogentos.ro"
}

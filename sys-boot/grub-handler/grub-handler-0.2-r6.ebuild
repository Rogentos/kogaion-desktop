# Copyright 2009-2014 Sabayon Linux
# Copyright 2015 Kogaion Linux
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="Kogaion Linux GRUB utilities"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install () {
	exeinto /usr/sbin
	doexe "${FILESDIR}/${PN}"
}

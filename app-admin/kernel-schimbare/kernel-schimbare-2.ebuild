# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit unpacker

DESCRIPTION="Schimba sau actualizeaza nucleul"
HOMEPAGE="http://rogentos.ro/"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/"${PN}"/"${PN}"-"${PV}".tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

RDEPEND=""
DEPEND=""

S="${WORKDIR}"

src_install() {
	#whatever
	insinto /sbin || die
	doins "${PN}" || die
	fperms 755 "/sbin/${PN}" || die
	fperms 755 "${PN}" || die
}

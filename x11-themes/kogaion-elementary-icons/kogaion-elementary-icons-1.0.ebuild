# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Kogaion elementary icons"
HOMEPAGE="https://github.com/bionel/kogaion-src"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/${PN}-${PV}.tar.gz
	http://pkg2.rogentos.ro/~noxis/distro/${CATEGORY}/${PN}/${PN}-${PV}.tar.gz"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

RDEPEND=""

DEPEND=""

DEST="/usr/share/icons"
S="${WORKDIR}"

src_install() {
	insinto ${DEST} || die
	doins -r "${S}"/Kogaion-elementary || die
	doins -r "${S}"/Kogaion-elementary-dark || die
}

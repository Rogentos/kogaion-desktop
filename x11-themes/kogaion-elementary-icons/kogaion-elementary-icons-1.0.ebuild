# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Kogaion elementary icons"
HOMEPAGE="https://github.com/bionel/kogaion-src"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/${P}.tar.gz
	http://buildserver.rogentos.ro/~kogaion/distro/${CATEGORY}/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

DEST="/usr/share/icons"
S="${WORKDIR}"

src_install() {
	insinto ${DEST} || die
	doins -r "${S}"/Kogaion-elementary || die
	doins -r "${S}"/Kogaion-elementary-dark || die
}

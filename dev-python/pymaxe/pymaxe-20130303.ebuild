# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

RP="pymaxe"

DESCRIPTION="Python support for Maxe"
HOMEPAGE="http://pymaxe.com"
SRC_URI="http://pymaxe.com/files/latest/${RP}.tar.gz -> ${PN}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

RDEPEND="x11-libs/pango"
DEPEND=""

S="${WORKDIR}"

src_compile() {
	cd "${S}"
}

src_install() {
	doins -r "${S}"/usr || die
}

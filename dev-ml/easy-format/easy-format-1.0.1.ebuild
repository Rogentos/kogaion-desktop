# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit findlib

DESCRIPTION="A functional interface to the Format libray in Ocaml"
HOMEPAGE="http://mjambon.com/easy-format.html"
SRC_URI="http://mjambon.com/releases/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/ocaml"

RDEPEND="${DEPEND}"

src_compile() {
	emake
}

src_install() {
	findlib_src_install
	dodoc README Changes
}

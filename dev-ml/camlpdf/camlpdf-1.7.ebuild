# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit findlib

DESCRIPTION="OCaml library for working with PDF files"
HOMEPAGE="http://github.com/johnwhitington/camlpdf"
SRC_URI="http://github.com/johnwhitington/camlpdf/archive/v${PV}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake -j1
	use doc && make doc
}

src_install() {
	findlib_src_install
}

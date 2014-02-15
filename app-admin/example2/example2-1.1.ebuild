# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit eutils

DESCRIPTION="Cacatul meu personal"
HOMEPAGE="http://rogentos.ro/"
SRC_URI="http://dl.dropbox.com/u/71039453/exemplu.tar.gz"
LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RDEPEND=""
DEPEND="${RPEDEND}"

src_prepare() {
        epatch "${FILESDIR}"/patch-1.1.patch || die
}
src_install() {
        dodir /home/cacatulmeupersonal || die "Creem folderul"
        insinto /home/cacatulmeupersonal || die "Intram in folder"
        doins exemplu1.txt || die "Copiem fisierul fisier din arhiva"
}

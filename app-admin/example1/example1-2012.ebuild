# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Cacatul meu personal"
HOMEPAGE="http://pkg.rogentos.ro/"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/fisier.tar.gz"

LICENSE="GPL-2"
IUSE="primulflag"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

RDEPEND=""
DEPEND="${RPEDEND}"

S="${WORKDIR}"

src_install() {
	dodir /home/cacatulmeupersonal || die "Creem folderul"
	insinto /home/cacatulmeupersonal || die "Intram in folder"
	doins fisier || die "Copiem fisierul fisier din arhiva"

	if use primulflag; then
		sed -i 's/CACAAT/ceva/g' fisier || die "Nu a reusit functia"
		insinto /home/cacatulmeupersonal/ || die
		doins fisier || die
	fi

	if ! use primulflag; then
		ewarn "Nu ai folosit flag-ul asta" || die
		echo "asta-i echo, dar modificat... genetic" || die
	fi

}

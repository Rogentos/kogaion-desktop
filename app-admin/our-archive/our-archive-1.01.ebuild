# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils

DESCRIPTION="Example X"
HOMEPAGE="http://rogentos.ro/"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/creation.tar.gz
	http://pkg2.rogentos.ro/~noxis/distro/creation.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-configurare"

RESTRICT="fetch strip"

RDEPEND=""
DEPEND=""

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}/creation-1.patch" || die #Aplicam patch-ul inainte
	sed -i 's/Acesta/Asta/g' creation.sh || die #Sed-uim fisierul
}

src_install() {
	if use configurare ; then
		dodir /home/$USER/test || die #Creaza director
		insinto /home/$USER/test || die #Intra in director
		doins creation.sh || die #Copiaza in directorul creat
	fi

	if ! use configurare ; then
		sed -i 's/Asta/Acesta inapoi/g' "${S}"/creation.sh || die #Schimba Asta inapoi cu Acesta, dar inapoi
		doins "${S}"/creation.sh /home/$USER/ || die #De data asta bagam fisierul unde trebe
	fi
}

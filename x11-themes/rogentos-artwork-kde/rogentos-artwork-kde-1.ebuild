# Copyright 1999-2012 Sabayon Linux
# Copyright 2012 Rogentos
# Distributed under the terms of the GNU General Public License v2
#

EAPI=4
CMAKE_REQUIRED="never"
inherit eutils kde4-base

DESCRIPTION="Rogentos Linux Official KDE Artwork"
HOMEPAGE="http://rogentos.ro/"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/${PN}.tar.gz"
	#http://pkg2.rogentos.ro/~noxis/distro/${CATEGORY}/${PN}.tar.gz"
LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ksplash"
RDEPEND=""

S="${WORKDIR}/${PN}"

src_install() {
	# KDM
	# debugging mode
	echo "Asta e ${KDEDIR}, cica"
	dodir ${KDEDIR}/share/apps/kdm/themes
	cd ${S}/kdm/ || die
	insinto ${KDEDIR}/share/apps/kdm/themes
	doins -r ./

	# Kwin
	dodir ${KDEDIR}/share/apps/aurorae/themes/
	cd ${S}/kwin || die
	insinto ${KDEDIR}/share/apps/aurorae/themes/
	doins -r ./

	# KSplash
	if use ksplash; then
		dodir ${KDEDIR}/share/apps/ksplash/Themes
		cd ${S}/ksplash || die
		insinto ${KDEDIR}/share/apps/ksplash/Themes
		doins -r ./
	fi
}

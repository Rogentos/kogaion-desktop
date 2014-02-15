# Copyright 2004-2012 Sabayon
# Copyright 2012 Rogentos
# Distributed under the terms of the GNU General Public License v2
#

EAPI=3

DESCRIPTION="Rogentos Linux Artwork Extras"
HOMEPAGE="http://rogentos.ro/"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/${PN}-${PVR}.tar.gz
	http://pkg2.rogentos.ro/~noxis/distro/${CATEGORY}/${PN}/${PN}-${PVR}.tar.gz"
LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_install () {
	# Compiz cube theme
	cd "${S}"/compiz
	dodir /usr/share/compiz
	insinto /usr/share/compiz/
	doins *.png

	# Emerald theme
	cd "${S}"/emerald
	dodir /usr/share/emerald/themes
	insinto /usr/share/emerald/themes/
	doins -r ./
}

# Copyright 2004-2011 Sabayon
# Copyright 2012 Kogaion
# Distributed under the terms of the GNU General Public License v2
# Original Authors Sabayon Team
# Maintainer BlackNoxis <stefan.cristian at rogentos.ro>

EAPI=4

inherit base

DESCRIPTION="Kogaion Isolinux Image Background"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/~kogaion/distro/${CATEGORY}/${PN}/${PN}-${PVR}.tar.gz"
	#http://pkg2.rogentos.ro/~noxis/distro/${CATEGORY}/${PN}/${PN}-${PVR}.tar.gz temporary out of duty repo
LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=""

S="${WORKDIR}"

src_install () {
	dodir /usr/share/backgrounds/isolinux || die
	insinto /usr/share/backgrounds/isolinux || die
	doins back.jpg || die
}

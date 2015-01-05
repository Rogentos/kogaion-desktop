# Copyright 2004-2012 Sabayon
# Copyright 2012 Kogaion
# Distributed under the terms of the GNU General Public License v2
# Maintainer BlackNoxis <stefan.cristian at rogentos.ro>

EAPI=4

inherit base mount-boot

DESCRIPTION="Kogaion-Linux GRUB2 Images"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/"${PN}"-${PV}.tar.gz"
LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="!x11-themes/sabayon-artwork-grub
	!x11-themes/rogentos-artwork-grub" #avoid file colision

S="${WORKDIR}"

src_install () {
	dodir /usr/share/grub
	insinto /usr/share/grub
	doins default-splash.png
}

pkg_postinst() {
	local dir="${ROOT}"boot/grub
	cp "${ROOT}/usr/share/grub/default-splash.png" "${dir}/default-splash.png" || \
		ewarn "cannot install default splash file!"
}

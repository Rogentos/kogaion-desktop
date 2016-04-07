# Copyright 2011-2015 Kogaion Linux
# Distributed under the terms of the GNU General Public License v2
# Maintainer BlackNoxis <stefan.cristian at rogentos.ro>

EAPI=4
inherit eutils mount-boot kogaion-artwork

DESCRIPTION="Offical Kogaion-Linux Core Artwork"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/distfiles/${CATEGORY}/${PN}/"${PN}"-${PV}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~arm x86 amd64"
IUSE=""
RDEPEND="sys-apps/findutils"

S="${WORKDIR}"/"${PN}"

src_install() {
	# Cursors
	insinto /usr/share/cursors/xorg-x11/
	doins -r "${S}"/mouse/RezoBlue

	# Wallpapers
	insinto /usr/share/backgrounds/
	doins -r "${S}"/background/nature

	# Logos
	insinto /usr/share/pixmaps/
	doins "${S}"/logo/*.png

	# Plymouth theme

	insinto /usr/share/plymouth
	doins "${S}"/plymouth/bizcom.png # back to our bizcom
	insinto /usr/share/plymouth/themes
	doins -r "${S}"/plymouth/themes/kogaion
	#insinto /usr/share/plymouth/
	#newins "${S}"/plymouth/themes/kogaion/kogaion-logo.png bizcom.png

	# Apply our tricks

	insinto /usr/share/cursors/xorg-x11
	dosym RezoBlue /usr/share/cursors/xorg-x11/default || "RezoBlue not found" #set default xcursor
}

pkg_postinst() {
	# mount boot first
	mount-boot_mount_boot_partition

	einfo "Please report bugs or glitches to"
	einfo "BlackNoxis"
}

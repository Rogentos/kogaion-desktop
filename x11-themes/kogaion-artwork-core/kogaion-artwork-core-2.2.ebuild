# Copyright 1999-2012 Sabayon Promotion
# Copyright 2011-2015 Kogaion Linux
# Distributed under the terms of the GNU General Public License v2
# Original Authors Sabayon Team
# Maintainer BlackNoxis <stefan.cristian at rogentos.ro>

EAPI=4
inherit eutils mount-boot kogaion-artwork

DESCRIPTION="Offical Kogaion-Linux Core Artwork"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/"${PN}"-${PV}.tar.gz
	mirror://kogaion/${CATEGORY}/"${PN}"/${P}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~arm x86 amd64"
IUSE=""
RDEPEND="sys-apps/findutils
	!<sys-boot/grub-0.97-r22
	!x11-themes/rogentos-artwork-core"

S="${WORKDIR}"/"${PN}"

src_install() {
	# Fbsplash theme - dropped!!!
	# insinto "${S}"/fbsplash
	# dodir /etc/splash/kogaion
	# insinto /etc/splash/kogaion/
	# doins -r "${S}"/fbsplash/kogaion/*

	# Cursors
	insinto /usr/share/cursors/xorg-x11/
	doins -r "${S}"/mouse/RezoBlue

	# Wallpapers
	insinto /usr/share/backgrounds/
	doins "${S}"/background/*.png 
	doins -r "${S}"/background/nature

	# Backdrop functionality for Xfce

	# drop, no longer needed with 4.12
	#insinto /usr/share/xfce4/backdrops/
	#doins "${S}"/background/*.png 
	#doins "${S}"/background/*.jpg

	# Plymouth theme

	#insinto /usr/share/plymouth
	#doins "${S}"/plymouth/bizcom.png # dropped with new script to avoid collision
	insinto /usr/share/plymouth/themes
	doins -r "${S}"/plymouth/themes/kogaion
	insinto /usr/share/plymouth/
	newins "${S}"/plymouth/themes/kogaion/kogaion-logo.png bizcom.png

	# Apply our tricks

	insinto /usr/share/cursors/xorg-x11
	dosym RezoBlue /usr/share/cursors/xorg-x11/default || "RezoBlue not found" #set default xcursor
	dosym /usr/share/backgrounds/entropy.png /usr/share/backgrounds/kgdm.png || "Failed to copy" #set bg for lightdm
	dosym /usr/share/backgrounds/flame.png /usr/share/backgrounds/kogaionlinux.png || "Failed to copy" #set bg for something unknown
}

pkg_postinst() {
	# mount boot first
	mount-boot_mount_boot_partition

	# Update Kogaion initramfs images
	# update_kogaion_kernel_initramfs_splash # Disabled. We DROP fbsplash!!!

	einfo "Please report bugs or glitches to"
	einfo "BlackNoxis"
}

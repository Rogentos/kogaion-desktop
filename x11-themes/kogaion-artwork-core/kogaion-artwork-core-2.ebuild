# Copyright 1999-2012 Sabayon Promotion
# Copyright 2012 Kogaion Linux
# Distributed under the terms of the GNU General Public License v2
# Original Authors Sabayon Team
# Maintainer BlackNoxis <stefan.cristian at rogentos.ro>

EAPI=4
inherit eutils mount-boot kogaion-artwork

DESCRIPTION="Offical Kogaion Linux Core Artwork"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/"${PN}"-${PV}.tar.gz"
	# http://pkg2.rogentos.ro/~noxis/distro/${CATEGORY}/${PN}/${PN}-${PVR}.tar.gz Temporray suspended repo

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~arm ~x86 ~amd64"
IUSE=""
RDEPEND="sys-apps/findutils
	!<sys-boot/grub-0.97-r22
	!x11-themes/sabayon-artwork-core
"

S="${WORKDIR}/"

src_install() {
	# Fbsplash theme
	insinto "${S}"/fbsplash
	dodir /etc/splash/kogaion
	insinto /etc/splash/kogaion/
	doins -r "${S}"/fbsplash/kogaion/*

	# Cursors
	cd "${S}"/mouse/entis/cursors/
	dodir /usr/share/cursors/xorg-x11/entis/cursors
	insinto /usr/share/cursors/xorg-x11/entis/cursors/
	doins -r ./

	# Wallpaper
	cd "${S}"/background
	insinto /usr/share/backgrounds
	doins *.png *.jpg
	#newins rogentoslinux.png rogentos-nvidia.png

	# Backdrop functionality for Xfce
	dodir /usr/share/xfce4/backdrops
	insinto /usr/share/xfce4/backdrops
	doins *.png *.jpg
}

pkg_postinst() {
	# mount boot first
	mount-boot_mount_boot_partition

	# Update Sabayon initramfs images
	update_kogaion_kernel_initramfs_splash

	einfo "Please report bugs or glitches to"
	einfo "BlackNoxis"
}

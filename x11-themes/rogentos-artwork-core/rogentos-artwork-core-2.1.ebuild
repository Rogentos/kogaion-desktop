# Copyright 1999-2012 Sabayon Promotion
# Copyright 2012 Rogentos Linux
# Distributed under the terms of the GNU General Public License v2
# Original Authors Sabayon Team
# Maintainer BlackNoxis <stefan.cristian at rogentos.ro>

EAPI=4
inherit eutils mount-boot rogentos-artwork

DESCRIPTION="Offical Rogentos Linux Core Artwork"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/${PN}-${PVR}.tar.xz"
	#http://pkg2.rogentos.ro/~noxis/distro/${CATEGORY}/${PN}/${PN}-${PVR}.tar.xz temporary out of duty repo

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~arm ~x86 ~amd64"
IUSE=""
RDEPEND="sys-apps/findutils
	!<sys-boot/grub-0.97-r22
"

S="${WORKDIR}/${PN}"

src_install() {
	# Fbsplash theme
	cd ${S}/fbsplash
	dodir /etc/splash/rogentos
	cp -r ${S}/fbsplash/rogentos/* ${D}/etc/splash/rogentos

	# Cursors
	cd ${S}/mouse/entis/cursors/
	dodir /usr/share/cursors/xorg-x11/entis/cursors
	insinto /usr/share/cursors/xorg-x11/entis/cursors/
	doins -r ./

	# Wallpaper
	cd "${S}"/background
	insinto /usr/share/backgrounds
	doins *.png *.jpg
	dosym /usr/share/backgrounds/Kogaion_tri_flame_wide.png /usr/share/backgrounds/kogaionlinux.png || die
	dosym /usr/share/backgrounds/Kogaion_tri_flame_wide.png /usr/share/backgrounds/kgdm.png || die
	#newins rogentoslinux.png rogentos-nvidia.png

	# Backdrop functionality for Xfce
	dodir /usr/share/xfce4/backdrops
	insinto /usr/share/xfce4/backdrops
	doins *.png *.jpg
	dosym /usr/share/xfce4/backdrops/Kogaion_tri_flame_wide.png /usr/share/xfce4/backdrops/kogaionlinux.png || die
	dosym /usr/share/xfce4/backdrops/Kogaion_blue_flame_wide.png /usr/share/xfce4/backdrops/kgdm.png || die
	#dosym kogaionlinux.png "Kogaion_tri_flame_wide.png"
	#dosym kgdm.png "Kogaion_blue_flame_wide.png"

	# Plymouth
	cd "${S}/plymouth/" || die
	insinto /usr/share/plymouth
	doins bizcom.png
	insinto /usr/share/plymouth/themes
	doins -r themes/rogentos

}

pkg_postinst() {
	# mount boot first
	mount-boot_mount_boot_partition

	# Update Sabayon initramfs images
	update_kogaion_kernel_initramfs_splash

	einfo "Please report bugs or glitches to"
	einfo "BlackNoxis"
}

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
	doins "Circles wide.png" kogaionlinux.png
	doins "Kogaion fuzzy 2.png" kgdm.png
	#newins rogentoslinux.png rogentos-nvidia.png

	# Backdrop functionality for Xfce
	dodir /usr/share/xfce4/backdrops
	insinto /usr/share/xfce4/backdrops
	doins *.png *.jpg
	doins "Circles wide.png" kogaionlinux.png
	doins "Kogaion fuzzy 2.png" kgdm.png

}

pkg_postinst() {
	# mount boot first
	mount-boot_mount_boot_partition

	# Update Sabayon initramfs images
	update_kogaion_kernel_initramfs_splash

	einfo "Please report bugs or glitches to"
	einfo "BlackNoxis"
}

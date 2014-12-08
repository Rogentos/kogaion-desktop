# Copyright 1999-2012 Sabayon Promotion
# Copyright 2012 Rogentos Linux
# Distributed under the terms of the GNU General Public License v2
# Original Authors Sabayon Team
# Maintainer BlackNoxis <stefan.cristian at rogentos.ro>

EAPI=4
inherit eutils mount-boot kogaion-artwork

DESCRIPTION="Offical Kogaion-Linux Core Artwork"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/"${PN}"-${PV}.tar.xz"
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
	# Fbsplash theme - dropped!!!
	# insinto "${S}"/fbsplash
	# dodir /etc/splash/kogaion
	# insinto /etc/splash/kogaion/
	# doins -r "${S}"/fbsplash/kogaion/*

	# Cursors
	cd "${S}"/mouse/RezoBlue
	dodir /usr/share/cursors/xorg-x11/RezoBlue
	insinto /usr/share/cursors/xorg-x11/RezoBlue || die "Cannot make target dir for cursors!"
	doins -r ./
	# Linking to our liked theme, instead of Adwaita (or whatever akward defaults)
	insinto /usr/share/cursors/xorg-x11/
	rm -f default
	dosym RezoBlue default || die "Target cursors not found!"

	# Wallpapers
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

	# Update Kogaion initramfs images
	# update_kogaion_kernel_initramfs_splash # Disabled. We DROP fbsplash!!!

	einfo "Please report bugs or glitches to"
	einfo "BlackNoxis"
}

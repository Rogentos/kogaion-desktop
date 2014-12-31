# Copyright 1999-2012 Sabayon Promotion
# Copyright 2012 Rogentos Linux
# Distributed under the terms of the GNU General Public License v2
# Original Authors Sabayon Team
# Maintainer BlackNoxis <stefan.cristian at rogentos.ro>

EAPI=4
inherit mount-boot rogentos-artwork

DESCRIPTION="Offical Rogentos Linux Core Artwork"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI=""

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~arm ~x86 ~amd64"
IUSE=""
RDEPEND=">=app-admin/stability-watcher-0.1
        app-misc/rogentos-version"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

pkg_config() {
        ewarn "This is ONLY for Sabayon-derived linux users" || die

        # mount boot first
        mount-boot_mount_boot_partition

        # Update Sabayon initramfs images
        update_kogaion_kernel_initramfs_splash

        einfo "Please report bugs or glitches to"
        einfo "BlackNoxis"
}

pkg_postinst() {
	# mount boot first
	mount-boot_mount_boot_partition

	# Update Sabayon initramfs images
	update_kogaion_kernel_initramfs_splash

	einfo "Please report bugs or glitches to"
	einfo "BlackNoxis"
}

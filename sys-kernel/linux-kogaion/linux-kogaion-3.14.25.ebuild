# Copyright 2004-2013 Sabayon Linux
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator

K_ROGKERNEL_SELF_TARBALL_NAME="kogaion"
K_REQUIRED_LINUX_FIRMWARE_VER="20140603"
K_ROGKERNEL_FORCE_SUBLEVEL="0"
K_ROGKERNEL_PATCH_UPSTREAM_TARBALL="0"

_ver="$(get_version_component_range 1-2)"
if use arm; then
	K_KERNEL_IMAGE_NAME="uImage dtbs"
elif [ "${_ver}" = "3.9" ]; then
	K_ROGKERNEL_ZFS="1"
fi
K_KERNEL_NEW_VERSIONING="1"

K_MKIMAGE_RAMDISK_ADDRESS="0x81000000"
K_MKIMAGE_RAMDISK_ENTRYPOINT="0x00000000"
K_MKIMAGE_KERNEL_ADDRESS="0x80008000"

inherit kogaion-kernel

KEYWORDS="~amd64 ~x86"
DESCRIPTION="Official Kogaion Linux Standard kernel image"
RESTRICT="mirror"

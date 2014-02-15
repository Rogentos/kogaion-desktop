# Copyright 2004-2014 Kogaion, Argent and ArgOS Linux
# Distributed under the terms of the GNU General Public License v2

EAPI=5

K_ROGKERNEL_NAME="rogentos"
K_ROGKERNEL_URI_CONFIG="yes"
K_ROGKERNEL_SELF_TARBALL_NAME="rogentos"
K_ONLY_SOURCES="1"
K_ROGKERNEL_FORCE_SUBLEVEL="0"
K_KERNEL_NEW_VERSIONING="1"
K_KERNEL_PATCH_HOTFIXES="${FILESDIR}/0001-rogentos-fix-rogentos-x86-kernel-config.patch"
inherit rogentos-kernel
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Official Kogaion, Argent and ArgOS Linux Standard kernel sources"
RESTRICT="mirror"
IUSE="sources_standalone"

DEPEND="${DEPEND}
	sources_standalone? ( !=sys-kernel/linux-rogentos-${PVR} )
	!sources_standalone? ( =sys-kernel/linux-rogentos-${PVR} )"

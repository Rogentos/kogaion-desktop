# Copyright 2004-2014 Kogaion, Argent and ArgOS Linux
# Distributed under the terms of the GNU General Public License v2

EAPI=5

K_ROGKERNEL_NAME="kogaion"
K_ROGKERNEL_URI_CONFIG="yes"
K_ROGKERNEL_SELF_TARBALL_NAME="kogaion"
K_ONLY_SOURCES="1"
K_ROGKERNEL_FORCE_SUBLEVEL="0"
K_KERNEL_NEW_VERSIONING="1"

inherit kogaion-kernel

KEYWORDS="~amd64 ~arm ~x86"
DESCRIPTION="Official Kogaion Linux Standard kernel sources"
RESTRICT="mirror"
IUSE="sources_standalone"

DEPEND="${DEPEND}
	sources_standalone? ( !=sys-kernel/linux-kogaion-${PVR} )
	!sources_standalone? ( =sys-kernel/linux-kogaion-${PVR} )"

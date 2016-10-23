# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Toggle discrete NVIDIA Optimus graphics card"
HOMEPAGE="https://github.com/Bumblebee-Project/bbswitch"
SLOT="0"
LICENSE="GPL-3+"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="=sys-kernel/${PN}-dkms-${PV}"
RDEPEND=""

S=${WORKDIR}

src_install() {
	insinto /etc/modprobe.d
	newins "${FILESDIR}"/bbswitch.modprobe bbswitch.conf
}

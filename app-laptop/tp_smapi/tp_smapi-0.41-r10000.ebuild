# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="IBM ThinkPad SMAPI BIOS driver dummy package"
HOMEPAGE="https://github.com/evgeni/tp_smapi/ http://tpctl.sourceforge.net/"
SRC_URI="mirror://github/evgeni/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="=sys-kernel/${PN}-dkms-${PV}"
RDEPEND="${DEPEND}"

src_compile(){
	:
}

src_install() {
	:
}

# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

MY_PN="tp_smapi"
MY_P="${MY_PN}-${PVR}"
DESCRIPTION="IBM ThinkPad SMAPI BIOS driver"
HOMEPAGE="https://github.com/evgeni/tp_smapi/ http://tpctl.sourceforge.net/"
SRC_URI="mirror://github/evgeni/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="sys-kernel/dkms"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"


src_prepare(){
	:
}

src_compile(){
	:
}

src_install() {
	cp "${FILESDIR}/dkms.conf" "${S}" || die
	dodir /usr/src/${P}
	insinto /usr/src/${P}
	doins -r "${S}"/*
}

pkg_postinst() {
	dkms add ${PN}/${PV}
}

pkg_prerm() {
	dkms remove ${PN}/${PV} --all
}

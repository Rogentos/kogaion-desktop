# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

MY_PN="bbswitch"
DESCRIPTION="BBswitch sources for linux"
HOMEPAGE="https://github.com/Bumblebee-Project/bbswitch"
SRC_URI="https://github.com/Bumblebee-Project/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-3+"
KEYWORDS="amd64"
IUSE=""
DEPEND="sys-kernel/dkms"
RDEPEND=""

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	# Fix build failure, bug #513542
	sed -i 's/^KDIR.*$/KDIR\ \:= \/usr\/src\/linux/g' Makefile
	epatch ${FILESDIR}/${P}-conf.patch
}

src_compile() {
	:
}

src_install() {
	dodir /usr/src/${P}
	insinto /usr/src/${P}
	doins -r ${S}/*
}

pkg_postinst() {
	dkms add ${PN}/${PV}
}

pkg_postrm() {
	dkms remove ${PN}/${PV} --all
}

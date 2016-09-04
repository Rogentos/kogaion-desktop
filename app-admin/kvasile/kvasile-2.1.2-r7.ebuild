# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2

DESCRIPTION="RogentOS Development Group buildbot, a safer alternative to Sabayons app-admin/matter"
HOMEPAGE="http://rogentos.ro"

EGIT_BRANCH="kogaion"
EGIT_REPO_URI="https://gitlab.com/rogentos/vasile.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	sys-fs/squashfs-tools
	sys-boot/grub:2
	dev-libs/libisoburn
	sys-fs/mtools"
RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/bin
	exeinto /usr/bin
	doexe ${S}/${PN}
	dodir /usr/$(get_libdir)/${PN}
	insinto /usr/$(get_libdir)/${PN}
	doins ${S}/libkvasile
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	insopts -m 755
	doins ${S}/make*
	doins ${S}/devmodeset
	doins ${S}/usermodeset
	doins ${S}/modereset
}


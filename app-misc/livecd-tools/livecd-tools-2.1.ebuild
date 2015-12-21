# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

SRC_URI="https://dev.gentoo.org/~williamh/dist/${P}.tar.gz"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"

DESCRIPTION="Gentoo LiveCD tools for autoconfiguration of hardware"
HOMEPAGE="http://wolf31o2.org/projects/livecd-tools"

SLOT="0"
LICENSE="GPL-2"
IUSE="systemd"

RDEPEND="dev-util/dialog
	net-dialup/mingetty
	>=sys-apps/baselayout-2
	sys-apps/gentoo-functions
	sys-apps/systemd
	sys-apps/pciutils
	sys-apps/gawk
	sys-apps/sed"

pkg_setup() {
		ewarn "This package is designed for use on the LiveCD only and will do"
		ewarn "unspeakably horrible and unexpected things on a normal system."
		ewarn "YOU HAVE BEEN WARNED!!!"
}

src_prepare() {
	epatch ""${FILESDIR}"/"${PN}"-systemd.patch"
}

src_install() {
	dosbin net-setup
	into /
	dosbin livecd-functions.sh
}

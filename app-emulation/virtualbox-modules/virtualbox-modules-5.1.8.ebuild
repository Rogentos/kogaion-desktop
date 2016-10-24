# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils user

MY_P=vbox-kernel-module-src-${PV}
DESCRIPTION="Kernel Modules for Virtualbox"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="https://dev.gentoo.org/~polynomial-c/virtualbox/${MY_P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="=sys-kernel/${PN}-dkms-${PV}"
RDEPEND="${DEPEND}
	!=app-emulation/virtualbox-9999"

S=${WORKDIR}


pkg_setup() {
	enewgroup vboxusers
}

src_compile() {
	:
}

src_install() {
	insinto /usr/lib/modules-load.d/
	doins "${FILESDIR}"/virtualbox.conf
}

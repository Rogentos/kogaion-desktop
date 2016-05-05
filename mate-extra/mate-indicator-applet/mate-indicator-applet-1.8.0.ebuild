# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Indicator Applet for MATE"
HOMEPAGE="http://mate-desktop.org"
SRC_URI="http://pub.mate-desktop.org/releases/1.8/${PN}-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	>=mate-base/mate-panel-${PV}"
DEPEND="
	>=sys-devel/autoconf-2.53
	>=sys-devel/automake-1.14.0
	>=sys-devel/libtool-2.4-r1
	>=dev-libs/glib-2.38.2-r1
	>=dev-util/pkgconfig-0.28-r1
	dev-libs/libindicator-gtk2
	dev-util/intltool"

S="${WORKDIR}/${PN}-${PV}"

src_configure() {
	econf \
		--disable-static
}

src_compile() {
	emake || die "compilation failed"
}

src_install() {
	default
}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4
inherit eutils flag-o-matic virtualx

MY_PN="libindicator"
DESCRIPTION="A set of symbols and convience functions that all indicators would like to use"
HOMEPAGE="http://launchpad.net/libindicator"
SRC_URI="http://launchpad.net/${MY_PN}/${PV%.*}/${PV}/+download/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND=">=dev-libs/glib-2.22
	>=x11-libs/gtk+-2.18:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-util/dbus-test-runner )"

S="${WORKDIR}/${MY_PN}-${PV}"

src_configure() {
	append-flags -Wno-error

	econf \
		--disable-silent-rules \
		--disable-static \
		--with-gtk=2
}

src_test() {
	Xemake check #391179
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	prune_libtool_files --all
}

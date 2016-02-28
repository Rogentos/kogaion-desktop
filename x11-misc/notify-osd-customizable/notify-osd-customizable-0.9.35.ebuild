# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4
inherit autotools gnome2-utils multilib savedconfig

P_N="notify-osd"
P_V="13.10.20130917.1"


DESCRIPTION="Canonical's on-screen-display notification agent,  with leolik patch added (customizable)."
HOMEPAGE="https://launchpad.net/~leolik/+archive/leolik"
SRC_URI="https://launchpad.net/~leolik/+archive/leolik/+files/${P_N}_${PV}+${P_V}-0ubuntu1-leolik~ppa0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+minimal"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.16
	>=x11-libs/gtk+-3.2:3
	>=x11-libs/libnotify-0.7
	>=x11-libs/libwnck-3
	x11-libs/libX11
	x11-libs/pixman
	!x11-misc/notify-osd
	!x11-misc/notification-daemon
	!x11-misc/qtnotifydaemon"
RDEPEND="${COMMON_DEPEND}
	!minimal? ( x11-themes/notify-osd-icons )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	gnome-base/gnome-common
	x11-proto/xproto"

RESTRICT="test" # virtualx.eclass: 1 of 1: FAIL: test-modules

DOCS=( AUTHORS ChangeLog NEWS README TODO )

S=${WORKDIR}/${P_N}-${PV}+${P_V}

src_prepare() {
	sed -i -e 's:noinst_PROG:check_PROG:' tests/Makefile.am || die
	restore_config src/{bubble,defaults,dnd}.c #428134
	eautoreconf
}

src_configure() {
	econf --libexecdir=/usr/$(get_libdir)/${P_N}
}

src_install() {
	default
	rm -f "${ED}"/usr/share/${P_N}/icons/*/*/*/README
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}
pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

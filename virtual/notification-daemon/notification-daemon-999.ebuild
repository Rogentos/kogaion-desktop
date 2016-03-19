# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Virtual for notification daemon dbus service"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 amd64-fbsd x86-fbsd x86-freebsd amd64-linux ~arm-linux x86-linux ~ppc-macos x86-macos x86-solaris"
IUSE="gnome mate xfce lxqt kde plasma"

RDEPEND="
	gnome? ( || ( x11-misc/notification-daemon
		gnome-base/gnome-shell
		x11-misc/notify-osd-customizable
		x11-misc/notify-osd ) )
	mate? ( || ( x11-misc/mate-notification-daemon
		x11-misc/notify-osd-customizable
		x11-misc/notify-osd ) )
	xfce? ( || ( x11-misc/notification-daemon
		xfce-extra/xfce4-notifyd
		x11-misc/notify-osd
		x11-misc/notify-osd-customizable ) )
	lxqt? ( || ( lxqt-base/lxqt-notificationd
		x11-misc/notification-daeomn
		x11-misc/notify-osd
		x11-misc/notify-osd-customizable ) )
	kde? ( || ( kde-misc/colibri
		kde-apps/knotify ) )
	plasma? ( kde-frameworks/knotifications ) "
DEPEND=""

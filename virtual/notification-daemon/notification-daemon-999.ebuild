# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Virtual for notification daemon dbus service"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 amd64-fbsd x86-fbsd x86-freebsd amd64-linux ~arm-linux x86-linux ~ppc-macos x86-macos x86-solaris"
IUSE="gnome mate xfce lxqt"

RDEPEND="
	gnome? ( x11-misc/notify-osd-customizable )
	mate? ( x11-misc/notify-osd-customizable )
	xfce? ( x11-misc/notify-osd-customizable )
	lxqt? ( x11-misc/notify-osd-customizable ) "
DEPEND=""

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Meta package containing deps on all xorg drivers (dummy version)"
HOMEPAGE="https://www.gentoo.org/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux"

IUSE=""

PDEPEND="
	!x11-drivers/xf86-input-citron
	!x11-drivers/xf86-video-cyrix
	!x11-drivers/xf86-video-impact
	!x11-drivers/xf86-video-nsc
	!x11-drivers/xf86-video-sunbw2
	!<=x11-drivers/xf86-video-ark-0.7.5
	!<=x11-drivers/xf86-video-newport-0.2.4
	!<=x11-drivers/xf86-video-sis-0.10.7
	!<=x11-drivers/xf86-video-v4l-0.2.0
"

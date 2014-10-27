# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-radeonhd/xf86-video-radeonhd-1.2.1.ebuild,v 1.3 2008/04/15 15:07:12 drac Exp $

EAPI="5"

inherit git-r3 x-modular

DESCRIPTION="Experimental Radeon HD video driver."
HOMEPAGE="http://wiki.x.org/wiki/radeonhd"
EGIT_REPO_URI="git://anongit.freedesktop.org/git/xorg/driver/xf86-video-radeonhd"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.3.0
	sys-apps/pciutils
	dri? ( >=media-libs/mesa-7.0.3 )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto
	dri? (
		x11-proto/glproto
		x11-proto/xf86driproto
	)"

src_install() {
	x-modular_src_install
	dobin utils/conntest/rhd_{conntest,dump}
}

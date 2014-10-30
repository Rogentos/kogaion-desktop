# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit autotools multilib
MY_PN="intel-driver-g45-h264"
MY_PV="20140512"

DESCRIPTION="HW video decode support for Intel integrated graphics (with h264 support for Intel G45 chipsets)"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/vaapi"
SRC_URI="https://downloads.sourceforge.net/project/g45h264/${MY_PN}-${MY_PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+drm wayland X"

RDEPEND=">=x11-libs/libva-1.3.0[X?,wayland?,drm?]
	!<x11-libs/libva-1.2.1[video_cards_intel]
	>=x11-libs/libdrm-2.4.45[video_cards_intel]
	!>x11-libs/libva-intel-driver-9999
	wayland? ( media-libs/mesa[egl] >=dev-libs/wayland-1 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_PN}

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-silent-rules \
		$(use_enable drm) \
		$(use_enable wayland) \
		$(use_enable X x11)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README || die
	find "${D}" -name '*.la' -delete
}

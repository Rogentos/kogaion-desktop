# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

EAPI="5"
inherit eutils autotools

DESCRIPTION="AMD Code Analyst"
HOMEPAGE="http://developer.amd.com/"
SRC_URI="http://developer.amd.com/wordpress/media/files/${PN}-3_4_18_0413-Public.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="X debug optimization"

RDEPEND=""
DEPEND="${DEPEND}"

S="${WORKDIR}"/CodeAnalyst-3_4_18_0413-Public


src_configure() {
	insinto "${S}"
	./autogen.sh || die "autogen failed"
        econf \
		$(use_enable debug) \
		$(use_enable optimization) \
		$(use_with X)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc NEWS README AUTHORS
	find "${D}" -name '*.la' -delete
}


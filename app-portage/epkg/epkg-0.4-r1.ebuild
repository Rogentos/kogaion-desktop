# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="A simple portage wrapper which works like other package managers"
HOMEPAGE="https://github.com/jdhore/epkg"
SRC_URI="https://github.com/jdhore/${PN}/archive/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}/${PN}-${P}"
DEPEND=""
RDEPEND="app-portage/eix
		app-portage/portage-utils
		sys-apps/portage"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-kogaion.patch
}

src_install() {
	dobin epkg
	dobin "${FILESDIR}"/kogaionsync
	doman doc/epkg.1
}

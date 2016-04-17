# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2

DESCRIPTION="A simple portage wrapper which works like other package managers"
HOMEPAGE="http://rogentos.ro"

EGIT_BRANCH=master
EGIT_REPO_URI="https://gitlab.com/kogaion/epkg.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="app-portage/gentoolkit
		app-portage/portage-utils
		sys-apps/portage"

src_install() {
	dobin epkg
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	insopts -m 755
	doins kogaionsync
}

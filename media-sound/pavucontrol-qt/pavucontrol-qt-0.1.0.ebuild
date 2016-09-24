# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 cmake-utils

DESCRIPTION="Qt port of pavucontrol"
HOMEPAGE="http://lxqt.org"
EGIT_REPO_URI="https://github.com/lxde/pavucontrol-qt.git"
EGIT_BRANCH="master"
EGIT_COMMIT="4ce124ce49071a97f9185a6e619608e8481a337a"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtdbus:5
	dev-qt/linguist-tools:5
	dev-libs/glib
	lxqt-base/liblxqt
	media-sound/pulseaudio"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch ${FILESDIR}/xdg-user-dirs-cmake-fix.patch
	cmake-utils_src_prepare
}

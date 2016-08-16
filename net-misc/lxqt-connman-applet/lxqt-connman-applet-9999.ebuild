# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 cmake-utils

DESCRIPTION="LXQt system-tray applet for ConnMan"
HOMEPAGE="https://github.com/surlykke/lxqt-connman-applet"

EGIT_REPO_URI="https://github.com/surlykke/lxqt-connman-applet.git"
EGIT_COMMIT="41126c9d9c5c348624488398aff24126be49a6c3"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="net-misc/connman
		lxqt-base/liblxqt
		dev-libs/libqtxdg
		dev-qt/qtdbus:5
		dev-qt/qtsvg:5
		dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"


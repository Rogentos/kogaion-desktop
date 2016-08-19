# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 cmake-utils

DESCRIPTION="Visual process manager - Qt version of ps/top"
HOMEPAGE="http://qps.kldp.net/projects/qps/"

EGIT_REPO_URI="https://github.com/QtDesktop/qps.git"
EGIT_COMMIT="7e679dbec168758273cb8475bc371501c1e67d09"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/linguist-tools:5"
RDEPEND="${DEPEND}"


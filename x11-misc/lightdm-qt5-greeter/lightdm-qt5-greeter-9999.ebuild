# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 cmake-utils

DESCRIPTION="A simple frontend for the lightdm displaymanager, written in c++ and qt5"
HOMEPAGE="http://rogentos.ro"
EGIT_REPO_URI="https://gitlab.com/kogaion/lightdm-qt5-greeter.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	x11-misc/lightdm[qt5]
"
DEPEND="${RDEPEND}
	dev-util/cmake"


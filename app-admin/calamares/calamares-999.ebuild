# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

EGIT_BRANCH="kogaion"
EGIT_COMMIT="5805b67793b6fb2c38da66d7bb9c88e35bb528a2"
EGIT_REPO_URI="https://gitlab.com/rogentos/calamares.git"

DESCRIPTION="Distribution-independent installer framework ( with Kogaionn/Sabayon support)"
HOMEPAGE="http://calamares.io"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
}

src_compile {
}

src_install {
}

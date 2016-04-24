# Copyright 2015 Rogentos
# Distributed under the terms of the GNU General Public License v3
# Maintainer bionel <bionel @ rogentos.ro >

EAPI=5

inherit eutils git-2

DESCRIPTION="Official Kogaion-Linux GTK theme"
HOMEPAGE="http://www.rogentos.ro"

EGIT_BRANCH="master"
EGIT_REPO_URI="https://gitlab.com/kogaion/kogaion-theme.git"
EGIT_COMMIT="ded3e5d50d2c324e2788d71e181d24a6190abb8e"


LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~arm x86 amd64"
IUSE=""
RDEPEND=""

src_install() {
	rm README.md
	rm to_review
	insinto /usr/share/themes
	doins -r *
}

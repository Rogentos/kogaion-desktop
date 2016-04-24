# Copyright 2015 Rogentos
# Distributed under the terms of the GNU General Public License v3
# Maintainer bionel <bionel @ rogentos.ro >

EAPI=5

DESCRIPTION="Official Kogaion-Linux GTK theme"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI="https://gitlab.com/kogaion/kogaion-theme/repository/archive.tar.gz?ref=2.1"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~arm x86 amd64"
IUSE=""
RDEPEND=""

S="${WORKDIR}"/"${P}"

src_install() {
	rm README.md
	rm to_review
	insinto /usr/share/themes
	doins -r *
}

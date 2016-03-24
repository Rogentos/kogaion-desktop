# Copyright 2004-2012 Sabayon
# Copyright 2012-2015 Kogaion
# Distributed under the terms of the GNU General Public License v2
# Maintainer BlackNoxis <stefan.cristian at rogentos.ro>

EAPI=5

inherit base mount-boot git-2 eutils

DESCRIPTION="Kogaion-Linux GRUB2 Images"
HOMEPAGE="http://www.rogentos.ro"

EGIT_BRANCH="master"
EGIT_REPO_URI="https://gitlab.com/kogaion/boot-core.git"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"

KEYWORDS="amd64 x86"
IUSE=""
RDEPEND=""

S="${WORKDIR}"

src_install () {
	dodir /usr/share/grub/themes || die
	insinto /usr/share/grub/themes || die 
	doins -r "${S}"/cdroot/boot/grub/themes/kogaion || die
}

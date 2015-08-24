# Copyright 2015 Gentoo
# Distributed under the terms of the GNU General Public License v2
# Maintainer bionel <bionel @ rogentos.ro >

EAPI=5
inherit eutils mount-boot kogaion-artwork

DESCRIPTION="Offical Kogaion-Linux Core Artwork"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/"${PN}"-${PV}.tar.gz
	mirror://kogaion/${CATEGORY}/"${PN}"/${P}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~arm x86 amd64"
IUSE=""
RDEPEND="sys-apps/findutils
	!<sys-boot/grub-0.97-r22
	!x11-themes/rogentos-artwork-core"

S="${WORKDIR}"/"${P}"

src_install() {
	rm README.md
	rm to_review
	insinto /usr/share/themes
	doins -r *
}

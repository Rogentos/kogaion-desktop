# Copyright 2012 Rogentos Linux
# Distributed under the terms of the GNU General Public License v2
# Maintainer BlackNoxis <stefan.cristian at rogentos.ro>
# $Header: $

EAPI=4

DESCRIPTION="Offical Rogentos Stability Watcher"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI=""

LICENSE="GPL-v2"
SLOT="0"
KEYWORDS="~arm ~x86 ~amd64"
IUSE=""
RDEPEND="sys-apps/openrc"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
        ewarn "This is available for only Entropy package manager" || die
        insinto /etc/entropy/packages/package.mask.d/
        doins "${FILESDIR}"/07-rogentos-packages.mask || die
	#insinto /etc/entropy/repositories.conf.d/
	#doins "${FILESDIR}"/entropy_sabayonlinux.org || die
}

pkg_postinst() {
	einfo "Please report bugs or glitches to"
	einfo "BlackNoxis"
}

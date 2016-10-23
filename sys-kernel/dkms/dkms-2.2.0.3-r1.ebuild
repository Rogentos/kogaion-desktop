# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils bash-completion-r1

DESCRIPTION="Dynamic Kernel Module Support"
SRC_URI="http://linux.dell.com/dkms/permalink/${P}.tar.gz"
HOMEPAGE="http://linux.dell.com/dkms"
LICENSE="GPL-2"
DEPEND=""
RDEPEND="sys-apps/gentoo-functions"
KEYWORDS="amd64"
SLOT="0"

src_prepare() {
	epatch ${FILESDIR}/${P}-dont-touch-configs.patch
	epatch ${FILESDIR}/${P}-gentoo-functions.patch
	epatch ${FILESDIR}/${P}-kogaion-systemd.patch
}

src_install() {
	emake DESTDIR=${D} install
}

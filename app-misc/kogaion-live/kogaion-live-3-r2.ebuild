# Copyright 2004-2014 Sabayon
# Copyright 2016 Kogaion
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_BRANCH="master"
EGIT_REPO_URI="https://gitlab.com/kogaion/kogaion-live.git"

inherit eutils systemd git-2

DESCRIPTION="Kogaion live scripts"
HOMEPAGE="http://www.rogentos.ro"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" SYSTEMD_UNITDIR="$(systemd_get_unitdir)" \
		install || die
}

pkg_postrm() {
	for service in "kogaionlive.service" ; do
		find "${ROOT}etc/systemd/system" -name "$service" -delete
	done
}

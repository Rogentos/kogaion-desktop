# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-2 autotools

DESCRIPTION="fuse module for access to iphone and ipod touch without jailbreak"
HOMEPAGE="http://www.kamailio.org/w/"
EGIT_REPO_URI="git://git.sip-router.org/kamailio"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	git-2_src_unpack
	die
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}

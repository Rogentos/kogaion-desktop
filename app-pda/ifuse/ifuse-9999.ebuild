# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit git-2 autotools

DESCRIPTION="fuse module for access to iphone and ipod touch without jailbreak"
HOMEPAGE="http://matt.colyer.name/projects/iphone-linux/"
EGIT_REPO_URI="http://github.com/mcolyer/ifuse.git"
EGIT_PROJECT="ifuse"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-pda/libimobiledevice
	>=sys-fs/fuse-2.7.0
	dev-libs/glib:2"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
	cd "${S}"
	./autogen.sh
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}

# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils git-2

DESCRIPTION="Open the KDE Plasma application launcher using the Super key (patched to bind Krunner to Super key)"
HOMEPAGE="https://github.com/hanschen/ksuperkey"

EGIT_BRANCH=master
EGIT_REPO_URI="https://github.com/hanschen/ksuperkey.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"

IUSE=""
DEPEND="x11-libs/libXtst
		x11-libs/libX11"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}


src_prepare() {
		epatch -p0 ${FILESDIR}/bind_krunner_to_super_key.patch
}

src_compile() {
        cd "${S}"
        make || die "Make failed"
}

src_install() {
        default
}

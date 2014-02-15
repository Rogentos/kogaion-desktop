# Copyright 1999-2010 Tiziano Müller
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit multilib toolchain-funcs

VB_V="4.1.18"
VB_P="VirtualBox-${VB_V}"

DESCRIPTION="Fuse module to open a VBox supported VD image file and mount it."
HOMEPAGE="https://forums.virtualbox.org/viewtopic.php?f=26&t=33355"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/${PN}-v${PV}.tar.bz2
	http://pkg3.rogentos.ro/~noxis/distro/${CATEGORY}/${PN}/${PN}-v${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=app-emulation/virtualbox-bin-${VB_V}
	sys-fs/fuse"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}"
incdir="${S}/include"
infile="${PN}-v${PV}.c"
outfile="${PN}"

pkg_setup() {
	ewarn "You may have to make /opt/VirtualBox/VBox{DDU,RT}.so"
	ewarn "readable for everyone first."

	if [ -z "${INSTALL_DIR}" ]; then
		if [ -e "/etc/vbox/vbox.cfg" ]; then
			. /etc/vbox/vbox.cfg
		elif [ -d "/usr/lib/virtualbox" ]; then
			INSTALL_DIR="/usr/lib/virtualbox"
		elif [ -z "${INSTALL_DIR}" ]; then
			echo "INSTALL_DIR not defined"
			exit 1
		fi
	fi

}

src_unpack() {
	unpack "${A}" || die "unpacking sources failed"
}

src_compile() {
	$(tc-getCC) \
		${CFLAGS} \
		$(pkg-config --cflags --libs fuse) \
		${LDFLAGS} \
		${infile} -o ${outfile} \
		-I${incdir} \
		-Wl,-rpath,${INSTALL_DIR} \
		-l:${INSTALL_DIR}/VBoxDDU.so \
		-Wall \
		|| die "building vdfuse failed"
}

src_install() {
	dobin vdfuse
}



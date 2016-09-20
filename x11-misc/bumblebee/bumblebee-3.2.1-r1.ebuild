# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bumblebee/bumblebee-3.2.1.ebuild,v 1.1 2013/05/26 18:55:23 pacho Exp $

EAPI=5
inherit eutils multilib readme.gentoo systemd user

DESCRIPTION="Service providing elegant and stable means of managing Optimus graphics chipsets"
HOMEPAGE="http://bumblebee-project.org https://github.com/Bumblebee-Project/Bumblebee"
SRC_URI="http://bumblebee-project.org/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="amd64 x86"

IUSE="+bbswitch +primus video_cards_nouveau video_cards_nvidia"

RDEPEND="
	virtual/opengl
	x11-misc/virtualgl:=
	primus? ( x11-misc/primus )
	bbswitch? ( sys-power/bbswitch )
"
DEPEND="${RDEPEND}
	dev-libs/glib:2
	dev-libs/libbsd
	sys-apps/help2man
	virtual/pkgconfig
	x11-libs/libX11
"

src_prepare() {
		# Dirty fix for issue https://github.com/Bumblebee-Project/Bumblebee/issues/699
		# cherry picked from https://github.com/arafey/Bumblebee/commit/5636b24fa86a005a5d2e30bd794516db13ccba56
		epatch "${FILESDIR}/${P}-handle-nvidia-modeset.patch"
}

src_configure() {
	DOC_CONTENTS="In order to use Bumblebee, add your user to 'bumblebee' group.
		You may need to setup your /etc/bumblebee/bumblebee.conf"

	if use video_cards_nvidia ; then
		# Get paths to GL libs for all ABIs
		local nvlib=""
		for i in  $(get_all_libdirs) ; do
			nvlib="${nvlib}:/usr/${i}/opengl/nvidia/lib"
		done

		local nvpref="/usr/$(get_libdir)/opengl/nvidia"
		local xorgpref="/usr/$(get_libdir)/xorg/modules"
		ECONF_PARAMS="CONF_DRIVER=nvidia CONF_DRIVER_MODULE_NVIDIA=nvidia \
			CONF_LDPATH_NVIDIA=${nvlib#:} \
			CONF_MODPATH_NVIDIA=${nvpref}/lib,${nvpref}/extensions,${xorgpref}/drivers,${xorgpref}"
	fi

	econf \
		--docdir=/usr/share/doc/"${PF}" \
		${ECONF_PARAMS}
}

src_install() {
	newconfd "${FILESDIR}"/bumblebee.confd bumblebee
	newinitd "${FILESDIR}"/bumblebee.initd bumblebee
	newenvd  "${FILESDIR}"/bumblebee.envd 99bumblebee
	systemd_dounit scripts/systemd/bumblebeed.service

	# Kogaion: tweak default settings
	sed -i "s:TurnCardOffAtExit=.*:TurnCardOffAtExit=true:g" \
		"${S}/conf/bumblebee.conf" || die

	readme.gentoo_create_doc

	default

	if use bbswitch; then
		# This is much better than the udev rule below
		doinitd "${FILESDIR}/bbswitch-setup"
		sed -i "s:need xdm:need bbswitch-setup xdm:" \
			"${ED}/etc/init.d/bumblebee" || die
	fi
	# Downstream says: this is just plain wrong, how about
	# the situation in where the user has bumblebee installed
	# but they are not actually on an Optimus system? This
	# disables the nvidia driver forever.
	##
	rm "${ED}/lib/udev/rules.d/99-bumblebee-nvidia-dev.rules" || die
}

pkg_preinst() {
	use video_cards_nvidia || rm "${ED}"/etc/bumblebee/xorg.conf.nvidia
	use video_cards_nouveau || rm "${ED}"/etc/bumblebee/xorg.conf.nouveau

	enewgroup bumblebee
}

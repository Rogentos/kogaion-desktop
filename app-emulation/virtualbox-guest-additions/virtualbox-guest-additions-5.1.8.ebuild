# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils systemd user toolchain-funcs

MY_PV="${PV/beta/BETA}"
MY_PV="${MY_PV/rc/RC}"
MY_P=VirtualBox-${MY_PV}
DESCRIPTION="VirtualBox user-space tools for Gentoo guests"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://download.virtualbox.org/virtualbox/${MY_PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="X"

RDEPEND="X? ( ~x11-drivers/xf86-video-virtualbox-${PV}
		x11-apps/xrandr
		x11-apps/xrefresh
		x11-libs/libXmu
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXext
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libSM
		x11-libs/libICE
		x11-proto/glproto )
	sys-apps/dbus
	=sys-kernel/virtualbox-guest-dkms-${PV}
	!!x11-drivers/xf86-input-virtualbox"
DEPEND="${RDEPEND}
	>=dev-util/kbuild-0.1.9998_pre20131130
	>=dev-lang/yasm-0.6.2
	sys-devel/bin86
	sys-libs/pam
	sys-power/iasl
	X? ( x11-proto/renderproto )
	!X? ( x11-proto/xproto )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup vboxguest
	enewuser vboxguest -1 /bin/sh /dev/null vboxguest
	enewgroup vboxsf
}

src_unpack() {
	unpack ${A}

	"${S}"/src/VBox/Additions/linux/export_modules "${WORKDIR}/vbox-kmod.tar.gz"
	unpack ./vbox-kmod.tar.gz

	cd "${S}"
	rm -rf kBuild/bin tools
}

src_prepare() {
	pushd "${WORKDIR}" &>/dev/null || die
	eapply "${FILESDIR}"/vboxguest-4.1.0-log-use-c99.patch
	popd &>/dev/null || die

	cp "${FILESDIR}/${PN}-5-localconfig" LocalConfig.kmk || die
	use X || echo "VBOX_WITH_X11_ADDITIONS :=" >> LocalConfig.kmk

	for vboxheader in {product,revision,version}-generated.h ; do
		for mdir in vbox{guest,sf} ; do
			ln -sf "${S}"/out/linux.${ARCH}/release/${vboxheader} \
				"${WORKDIR}/${mdir}/${vboxheader}"
		done
	done

	sed -e "/\s*-o\s*\\\(\s*\$cc_maj\s*-eq\s*[5-9]\s*-a\s*\$cc_min\s*-gt\s*[0-5]\s*\\\)\s*\\\/d" \
		-i configure || die

	eapply_user
}

src_configure() {
	local cmd=(
		./configure
		--nofatal
		--disable-xpcom
		--disable-sdl-ttf
		--disable-pulse
		--disable-alsa
		--with-gcc="$(tc-getCC)"
		--with-g++="$(tc-getCXX)"
		--target-arch=${ARCH}
		--with-linux="${KV_OUT_DIR}"
		--build-headless
	)
	echo "${cmd[@]}"
	"${cmd[@]}" || die "configure failed"
	source ./env.sh
	export VBOX_GCC_OPT="${CFLAGS} ${CPPFLAGS}"
}

src_compile() {
	MAKE="kmk" \
	emake TOOL_YASM_AS=yasm \
	VBOX_ONLY_ADDITIONS=1
}

src_install() {
	cd "${S}"/out/linux.${ARCH}/release/bin/additions || die

	insinto /sbin
	newins mount.vboxsf mount.vboxsf
	fperms 4755 /sbin/mount.vboxsf

	newinitd "${FILESDIR}"/${PN}-8.initd ${PN}

	insinto /usr/sbin/
	newins VBoxService vboxguest-service
	fperms 0755 /usr/sbin/vboxguest-service

	insinto /usr/bin
	doins VBoxControl
	fperms 0755 /usr/bin/VBoxControl

	if use X ; then
		doins VBoxClient
		fperms 0755 /usr/bin/VBoxClient

		pushd "${S}"/src/VBox/Additions/x11/Installer &>/dev/null \
			|| die
		newins 98vboxadd-xclient VBoxClient-all
		fperms 0755 /usr/bin/VBoxClient-all
		popd &>/dev/null || die
	fi

	local udev_rules_dir="/lib/udev/rules.d"
	dodir ${udev_rules_dir}
	echo 'KERNEL=="vboxguest", OWNER="vboxguest", GROUP="vboxguest", MODE="0660"' \
		>> "${D}/${udev_rules_dir}/60-virtualbox-guest-additions.rules" \
		|| die
	echo 'KERNEL=="vboxuser", OWNER="vboxguest", GROUP="vboxguest", MODE="0660"' \
		>> "${D}/${udev_rules_dir}/60-virtualbox-guest-additions.rules" \
		|| die

	insinto /etc/xdg/autostart
	doins "${FILESDIR}"/vboxclient.desktop

	insinto /usr/share/doc/${PF}
	doins "${FILESDIR}"/xorg.conf.vbox

	systemd_dounit "${FILESDIR}/${PN}.service"
}

pkg_postinst() {
	if ! use X ; then
		elog "use flag X is off, enable it to install the"
		elog "X Window System video driver."
	fi
	elog ""
	elog "Please add users to the \"vboxguest\" group so they can"
	elog "benefit from seamless mode, auto-resize and clipboard."
	elog ""
	elog "The vboxsf group has been added to make automount services work."
	elog "These services are part of the shared folders support."
	elog ""
	elog "Please add:"
	elog "/etc/init.d/${PN}"
	elog "to the default runlevel in order to start"
	elog "needed services."
	elog "To use the VirtualBox X driver, use the following"
	elog "file as your /etc/X11/xorg.conf:"
	elog "    /usr/share/doc/${PF}/xorg.conf.vbox"
	elog ""
	elog "Also make sure you use the Mesa library for OpenGL:"
	elog "    eselect opengl set xorg-x11"
	elog ""
	elog "An autostart .desktop file has been installed to start"
	elog "VBoxClient in desktop sessions."
	elog ""
	elog "You can mount shared folders with:"
	elog "    mount -t vboxsf <shared_folder_name> <mount_point>"
	elog ""
	elog "Warning:"
	elog "this ebuild is only needed if you are running gentoo"
	elog "inside a VirtualBox Virtual Machine, you don't need"
	elog "it to run VirtualBox itself."
	elog ""
}

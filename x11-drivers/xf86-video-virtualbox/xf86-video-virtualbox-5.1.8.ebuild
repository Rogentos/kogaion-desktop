# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit eutils multilib python-single-r1 versionator toolchain-funcs

MY_PV="${PV/beta/BETA}"
MY_PV="${MY_PV/rc/RC}"
MY_P=VirtualBox-${MY_PV}
DESCRIPTION="VirtualBox video driver"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://download.virtualbox.org/virtualbox/${MY_PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dri"

RDEPEND="=sys-kernel/virtualbox-guest-dkms-${PV}
	>=x11-base/xorg-server-1.7:=[-minimal]
	x11-libs/libXcomposite"
DEPEND="${RDEPEND}
	>=dev-util/kbuild-0.1.9998_pre20131130
	${PYTHON_DEPS}
	>=dev-lang/yasm-0.6.2
	>=sys-devel/gcc-4.9.0
	sys-power/iasl
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/resourceproto
	x11-proto/scrnsaverproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xproto
	x11-libs/libXdmcp
	x11-libs/libXau
	x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libXext
	dri? (  x11-proto/xf86driproto
		>=x11-libs/libdrm-2.4.5 )"

REQUIRED_USE=( "${PYTHON_REQUIRED_USE}" )

S="${WORKDIR}/${MY_P}"

PATCHES=(
	# Ugly hack to build the opengl part of the video driver
	"${FILESDIR}/${PN}-2.2.0-enable-opengl.patch"

	# unset useless/problematic checks in configure
	"${FILESDIR}/${PN}-5.0.0_beta3-configure_checks.patch"
)

QA_TEXTRELS_x86="usr/lib/VBoxOGL.so"

pkg_setup() {
	if [ "${MERGE_TYPE}" != "binary" ]; then
		version_is_at_least 4.9 $(gcc-version) || die "Please set gcc 4.9 or higher as active in gcc-config to build ${PN}"
	fi

	python-single-r1_pkg_setup
}

src_prepare() {
	eapply "${FILESDIR}"/${PN}-5.1.4-Makefile.module.kms.patch

	rm -r kBuild/bin tools || die

	cp "${FILESDIR}/${PN}-5-localconfig" LocalConfig.kmk || die

	sed -e "/\s*-o\s*\\\(\s*\$cc_maj\s*-eq\s*[5-9]\s*-a\s*\$cc_min\s*-gt\s*[0-5]\s*\\\)\s*\\\/d" \
		-i configure || die

	default

	sed '/^TEMPLATE_VBOXR3EXE_LDFLAGS.linux/s/$/ -Wl,-z,lazy/' \
		-i Config.kmk || die
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
	local each targets=(
		Runtime
		Additions/common/VBoxGuestLib
		GuestHost/OpenGL
		Additions/x11/x11stubs
		Additions/common/crOpenGL
		Additions/x11/vboxvideo
	)

	use dri && targets+=( Additions/linux/drm )

	for each in ${targets[@]} ; do
		pushd "${S}"/src/VBox/${each} $>/dev/null || die
		MAKE="kmk" \
		emake TOOL_YASM_AS=yasm \
		VBOX_USE_SYSTEM_XORG_HEADERS=1 \
		KBUILD_PATH="${S}/kBuild" \
		KBUILD_VERBOSE=2
		popd &>/dev/null || die
	done

	if use dri; then
		local objdir="out/linux.${ARCH}/release/obj/vboxvideo_drm"
		targets=(
			include
			src/VBox/Runtime/r0drv
			src/VBox/Installer/linux/Makefile.include.{head,foot}er
			out/linux.${ARCH}/release/{product,version,revision}-generated.h
		)
		for each in ${targets[@]} ; do
			:
		done
		targets=(
			dt/dt/common/VBoxVideo/HGSMIBase.o
			dt/dt/common/VBoxVideo/Modesetting.o
			dt/dt/common/VBoxVideo/VBVABase.o
			dt/dt/dt/GuestHost/HGSMI/HGSMICommon.o
			dt/dt/dt/GuestHost/HGSMI/HGSMIMemAlloc.o
			dt/dt/dt/Runtime/common/alloc/heapoffset.o
		)
		for each in ${targets[@]} ; do
			:
		done

	fi
}

src_install() {
	if use dri; then
		:
	fi

	cd "${S}/out/linux.${ARCH}/release/bin/additions" || die
	insinto /usr/$(get_libdir)/xorg/modules/drivers
	newins vboxvideo_drv_system.so vboxvideo_drv.so

	insinto /usr/$(get_libdir)
	doins -r VBoxOGL*

	if use dri ; then
		dosym /usr/$(get_libdir)/VBoxOGL.so \
			/usr/$(get_libdir)/dri/vboxvideo_dri.so
	fi
}

pkg_postinst() {
	elog "You need to edit the file /etc/X11/xorg.conf and set:"
	elog ""
	elog "  Driver  \"vboxvideo\""
	elog ""
	elog "in the Graphics device section (Section \"Device\")"
	elog ""
	if use dri; then
		elog "To use the kernel drm video driver, please add:"
		elog "\"${MODULE_NAMES%(*}\" to:"
		if has_version sys-apps/openrc ; then
			elog "/etc/conf.d/modules"
		else
			elog "/etc/modules.autoload.d/kernel-${KV_MAJOR}.${KV_MINOR}"
		fi
		elog ""
	fi
}

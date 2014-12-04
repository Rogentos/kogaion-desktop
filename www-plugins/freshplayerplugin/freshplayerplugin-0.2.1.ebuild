# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils cmake-multilib nsplugins

DESCRIPTION="ppapi2npapi compatibility layer"
HOMEPAGE="https://github.com/i-rinat/freshplayerplugin"
SRC_URI="https://github.com/i-rinat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT LGPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-util/ragel
	dev-libs/libconfig
	media-libs/freetype:2
	>=dev-libs/glib-2.38.2-r1:2
	>=dev-util/cmake-2.8.8
	>=media-libs/alsa-lib-1.0.28
	>=x11-libs/pango-1.36.5
	>=x11-libs/libXinerama-1.1.3
	>=x11-libs/gtk+-2.20:2
	>=media-libs/mesa-10.0.4
	>=dev-libs/libevent-2.0.21-r1
	"
RDEPEND="
	www-plugins/chrome-binary-plugins"

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/find-chrome-binary-plugins-flash.patch
}

multilib_src_configure() {
	local mycmakeargs="-DFRESHPLAYERPLUGINPATH=${EPREFIX}/usr/$(get_libdir)/freshplayerplugin"

	cmake-utils_src_configure
}

multilib_src_install() {
		# install the wrapper
		exeinto /usr/$(get_libdir)/${PLUGINS_DIR}
		doexe libfreshwrapper-pepperflash.so
		# install wrapper configuration file
		cd "${S}"
		dodir /usr/share/${PN} || die
		insinto /usr/share/${PN} || die
		doins -r "${S}"/data/freshwrapper.conf.example || die
		dosym /usr/share/${PN}/freshwrapper.conf.example /etc/freshwrapper.conf || die
}

# Copyright 1999-2012 Sabayon
# Copyright 2015 Kogaion
# Distributed under the terms of the GNU General Public License v2
# Header: $

EAPI=4

inherit gnome2-utils

DESCRIPTION="Kogaion Linux Official GNOME artwork"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/"${PN}"-${PV}.tar.gz"
LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
RDEPEND=">=x11-themes/rogentos-artwork-core-2
	x11-themes/kogaion-light-theme
	x11-themes/kogaion-dark-theme
	x11-themes/faenza-kupertino-icons
	!x11-themes/sabayon-artwork-gnome"

S="${WORKDIR}/"

src_install() {
#	dodir /usr/share/themes

	# GNOME & GTK Theme
#	cd "${S}"/gtk
#	dodir /usr/share/themes
#	insinto /usr/share/themes
#	doins -r ./*

	# Metacity
#	cd "${S}"/metacity
#	insinto /usr/share/themes
#	doins -r ./*

	# GNOME 3 config settings
	dodir /usr/share/glib-2.0/schemas
	insinto /usr/share/glib-2.0/schemas
	doins "${FILESDIR}/org.kogaion.gschema.override"

	# GDM 3.6+ logo stuff
	cd "${S}/gdm"
	dodir /usr/share/kogaion/gdm
	insinto /usr/share/kogaion/gdm
	doins logo.svg
	insinto /usr/share/glib-2.0/schemas
	doins org.gnome.login-screen.gschema.override
}

pkg_preinst() {
	# taken from gnome2_schemas_savelist
	has ${EAPI:-0} 0 1 2 && ! use prefix && ED="${D}"
	pushd "${ED}" &>/dev/null
	export GNOME2_ECLASS_GLIB_SCHEMAS="/usr/share/glib-2.0/schemas/org.kogaion.gschema.override"
	popd &>/dev/null
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update --uninstall
}

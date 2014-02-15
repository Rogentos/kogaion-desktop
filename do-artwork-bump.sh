#!/bin/bash
# made by Sabayon GNU/Linux Team
if [ -z "$2" ]; then
	echo do-artwork-bump.sh OLDVER NEWVER
	exit
fi

OLD=$1
NEW=$2
PACKAGES="x11-themes/rogentos-artwork-core x11-themes/rogentos-artwork-extra \
		x11-themes/rogentos-artwork-kde x11-themes/rogentos-artwork-gnome \
			x11-themes/rogentos-artwork-loo x11-themes/rogentos-artwork-lxde\
			x11-themes/rogentos-artwork-grub x11-themes/rogentos-artwork-isolinux"

for package in ${PACKAGES}; do
	name=$(echo ${package} | cut -d/ -f2)
	if [ -a ${package}/${name}-${NEW}.ebuild ]; then
		echo "${NEW} ebuild found, not overwriting"
	else
		cp ${package}/${name}-${OLD}.ebuild ${package}/${name}-${NEW}.ebuild
	fi
	ebuild ${package}/${name}-${NEW}.ebuild manifest --force clean install clean
	git add ${package}/${name}-${NEW}.ebuild
	git add ${package}/Manifest
done

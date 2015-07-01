#!/bin/bash
# made by Sabayon GNU/Linux Team
if [ -z "$2" ]; then
	echo do-artwork-bump.sh OLDVER NEWVER
	exit
fi

OLD=$1
NEW=$2
PACKAGES="x11-themes/kogaion-artwork-core x11-themes/kogaion-artwork-extra \
		x11-themes/kogaion-artwork-kde x11-themes/kogaion-artwork-gnome \
			x11-themes/kogaion-artwork-loo x11-themes/kogaion-artwork-lxde\
			x11-themes/kogaion-artwork-grub x11-themes/kogaion-artwork-isolinux"

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

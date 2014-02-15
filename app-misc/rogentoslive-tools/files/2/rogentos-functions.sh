#!/bin/bash

GDM_FILE="/usr/share/gdm/defaults.conf"
CUSTOM_GDM_FILE="/etc/gdm/custom.conf"
KDM_FILE="/usr/share/config/kdm/kdmrc"
LXDM_FILE="/etc/lxdm/lxdm.conf"
LIGHTDM_FILE="/etc/lightdm/lightdm.conf"
OEM_FILE="/etc/oemlive.sh"
OEM_FILE_NEW="/etc/oem/liveboot.sh"
LIVE_USER_GROUPS="audio bumblebee cdrom cdrw clamav console entropy games \
kvm lp lpadmin messagebus plugdev polkituser portage pulse pulse-access pulse-rt \
scanner usb users uucp vboxguest vboxusers video wheel"
LIVE_USER=${ROGENTOS_USER:-rogentosuser}

rogentos_setup_autologin() {
	# GDM - GNOME
	if [ -f "${GDM_FILE}" ]; then
		sed -i "s/^AutomaticLoginEnable=.*/AutomaticLoginEnable=true/" ${GDM_FILE}
		sed -i "s/^AutomaticLogin=.*/AutomaticLogin=${LIVE_USER}/" ${GDM_FILE}

		sed -i "s/^TimedLoginEnable=.*/TimedLoginEnable=true/" ${GDM_FILE}
		sed -i "s/^TimedLogin=.*/TimedLogin=${LIVE_USER}/" ${GDM_FILE}
		sed -i "s/^TimedLoginDelay=.*/TimedLoginDelay=0/" ${GDM_FILE}

	elif [ -f "${CUSTOM_GDM_FILE}" ]; then
		# FIXME: if this is called multiple times, it generates duplicated entries
		sed -i "s:\[daemon\]:\[daemon\]\nAutomaticLoginEnable=true\nAutomaticLogin=${LIVE_USER}\nTimedLoginEnable=true\nTimedLogin=${LIVE_USER}\nTimedLoginDelay=0:" \
			"${CUSTOM_GDM_FILE}"
		# change other entries there
		sed -i "s/^TimedLogin=.*/TimedLogin=${LIVE_USER}/" "${CUSTOM_GDM_FILE}"
		sed -i "s/^AutomaticLogin=.*/AutomaticLogin=${LIVE_USER}/" "${CUSTOM_GDM_FILE}"
	fi

	# KDM - KDE
	if [ -f "$KDM_FILE" ]; then
		sed -i "s/AutoLoginEnable=.*/AutoLoginEnable=true/" $KDM_FILE
		sed -i "s/AutoLoginUser=.*/AutoLoginUser=${LIVE_USER}/" $KDM_FILE
		sed -i "s/AutoLoginDelay=.*/AutoLoginDelay=0/" $KDM_FILE
		sed -i "s/AutoLoginAgain=.*/AutoLoginAgain=true/" $KDM_FILE

		sed -i "s/AllowRootLogin=.*/AllowRootLogin=true/" $KDM_FILE
		sed -i "s/AllowNullPasswd=.*/AllowNullPasswd=true/" $KDM_FILE
		sed -i "s/AllowShutdown=.*/AllowShutdown=All/" $KDM_FILE

		sed -i "/^#.*AutoLoginEnable=/ s/^#//" $KDM_FILE
		sed -i "/^#.*AutoLoginUser=/ s/^#//" $KDM_FILE
		sed -i "/^#.*AutoLoginDelay=/ s/^#//" $KDM_FILE
		sed -i "/^#.*AutoLoginAgain=/ s/^#//" $KDM_FILE

		sed -i "/^#AllowRootLogin=/ s/^#//" $KDM_FILE
		sed -i "/^#AllowNullPasswd=/ s/^#//" $KDM_FILE
		sed -i "/^#AllowShutdown=/ s/^#//" $KDM_FILE
	fi

	# LXDM
	if [ -f "$LXDM_FILE" ]; then
		sed -i "s/autologin=.*/autologin=${LIVE_USER}/" $LXDM_FILE
		sed -i "/^#.*autologin=/ s/^#//" $LXDM_FILE
	fi

	# LightDM
	if [ -f "$LIGHTDM_FILE" ]; then
		sed -i "s/autologin-user=.*/autologin-user=${LIVE_USER}/" $LIGHTDM_FILE
		sed -i "/^#.*autologin-user=/ s/^#//" $LIGHTDM_FILE
	fi

	# Setup correct login session
	rogentos_is_normal_boot && rogentos_fixup_gnome_autologin_session
}

rogentos_disable_autologin() {
	# GDM - GNOME
	if [ -f "${GDM_FILE}" ]; then
		sed -i "s/^AutomaticLoginEnable=.*/AutomaticLoginEnable=false/" ${GDM_FILE}
	fi

	# KDM - KDE
	KDM_FILE="/usr/share/config/kdm/kdmrc"
	if [ -f "$KDM_FILE" ]; then
		sed -i "s/AutoLoginEnable=.*/AutoLoginEnable=false/" $KDM_FILE
	fi

	# LXDM
	if [ -f "$LXDM_FILE" ]; then
		sed -i "s/^autologin=.*/autologin=/" $LXDM_FILE
	fi

	# LightDM
	if [ -f "$LIGHTDM_FILE" ]; then
		sed -i "s/^autologin-user=.*/#autologin-user=/" $LIGHTDM_FILE
	fi
}

rogentos_setup_live_user() {
	local live_user="${1}"
	local live_uid="${2}"
	if [ -z "${live_user}" ]; then
		live_user="${LIVE_USER}"
	fi
	if [ -n "${live_uid}" ]; then
		live_uid="-u ${live_uid}"
	fi
	id ${live_user} &> /dev/null
	if [ "${?}" != "0" ]; then
		local live_groups=""
		local avail_groups=$(cat /etc/group | cut -d":" -f 1 | xargs echo)
		for a_group in ${avail_groups}; do
			for p_group in ${LIVE_USER_GROUPS}; do
				if [ "${p_group}" = "${a_group}" ]; then
					if [ -z "${live_groups}" ]; then
						live_groups="${p_group}"
					else
						live_groups="${live_groups},${p_group}"
					fi
				fi
			done
		done
		# then setup live user, that is missing
		useradd -d "/home/${live_user}" -g root -G ${live_groups} -c "rogentosuser" \
			-m -N -p "" -s /bin/bash ${live_uid} "${live_user}"
		return 0
	fi
	return 1
}

rogentos_setup_motd() {
	echo -e "\n\tWelcome to `cat /etc/rogentos-edition`\n\t`uname -p`\n\t`uname -o` `uname -r`\n" > /etc/motd
}

rogentos_setup_vt_autologin() {
	if openrc_running; then
		. /sbin/livecd-functions.sh
		export CDBOOT=1
		livecd_fix_inittab
	elif systemd_running; then
		cp /usr/lib/systemd/system/getty@.service \
			/etc/systemd/system/autologin@.service
		sed -i "/^ExecStart=/ s:/sbin/agetty:/sbin/agetty --autologin root:g" \
			/usr/lib/systemd/system/getty@.service
		sed -i "/^ExecStart=/ s:--noclear::g" \
			/usr/lib/systemd/system/getty@.service
		systemctl daemon-reload
		systemctl restart getty@tty1
	fi
}

rogentos_setup_oem_livecd() {
	if [ -x "${OEM_LIVE_NEW}" ]; then
		${OEM_FILE_NEW} || return 1
	elif [ -x "${OEM_LIVE}" ]; then
		${OEM_FILE} || return 1
	fi
	return 0
}

rogentos_is_live() {
	local cmdl=$(cat /proc/cmdline | grep cdroot)
	if [ -n "${cmdl}" ]; then
		return 0
	else
		return 1
	fi
}

rogentos_setup_gui_installer() {
	# Configure Fluxbox
	local dmrc_file="/home/${LIVE_USER}/.dmrc"
	local flux_dir="/home/${LIVE_USER}/.fluxbox"
	local flux_startup_file="${flux_dir}/startup"
	if [ ! -d "${flux_dir}" ]; then
		mkdir "${flux_dir}" && chown "${LIVE_USER}" "${flux_dir}"
	fi
	echo "[Desktop]" > "${dmrc_file}"
	echo "Session=fluxbox" >> "${dmrc_file}"
	chown rogentosuser "${dmrc_file}"
	sed -i "/installer --fullscreen/ s/^# //" "${flux_startup_file}"
	if [ -x "/usr/libexec/gdm-set-default-session" ]; then
		# oh my fucking glorious god, this
		# is AccountsService bullshit
		# cross fingers
		/usr/libexec/gdm-set-default-session fluxbox
	fi
	if [ -x "/usr/libexec/gdm-set-session" ]; then
		# GDM 3.6 support
		/usr/libexec/gdm-set-session rogentosuser fluxbox
	fi
}

# This function reads /etc/skel/.dmrc and properly
# set the Session= value inside AccountsService.
# Blame the idiots who broke de-facto standards
# and created this fugly thing called AccountsService
rogentos_fixup_gnome_autologin_session() {
	local cur_session=

	if [ -f "/etc/skel/.dmrc" ]; then
		cur_session=$(cat /etc/skel/.dmrc | grep ^Session | cut -d"=" -f 2)
	fi
	if [ -z "${cur_session}" ]; then
		return 0
	fi

	local sess_file="/usr/share/xsessions/${cur_session}.desktop"
	if [ ! -f "${sess_file}" ]; then
		return 0
	fi

	if [ -x "/usr/libexec/gdm-set-default-session" ]; then
		# this edits /etc/gdm/custom.conf adding [daemon]\nDefaultSession=${cur_session}
		/usr/libexec/gdm-set-default-session "${cur_session}"
	fi

	if [ -x "/usr/libexec/gdm-set-session" ]; then
		# GDM 3.6 support
		local users_in_users=$(cat /etc/group | grep "^users" | awk -F':' '{ print $4 }' | sed "s:,: :g")
		for usr in ${users_in_users}; do
			/usr/libexec/gdm-set-session "${usr}" "${cur_session}"
		done
	fi
}

rogentos_setup_text_installer() {
	if openrc_running; then
		# switch to verbose mode
		splash_manager -c set -t default -m v &> /dev/null
		reset
		chvt 1
		clear
	fi
	rogentos_setup_text_installer_motd
}

rogentos_setup_text_installer_motd() {
	echo "Welcome to RogentOS Linux Text installation." >> /etc/motd
	echo "to run the installation type: installer <and PRESS ENTER>" >> /etc/motd
}

rogentos_is_text_install() {
	local _is_install=$(cat /proc/cmdline | grep installer-text)
	if [ -n "${_is_install}" ]; then
		return 0
	else
		return 1
	fi
}

rogentos_is_gui_install() {
	local _is_install=$(cat /proc/cmdline | grep installer-gui)
	if [ -n "${_is_install}" ]; then
		return 0
	else
		return 1
	fi
}

rogentos_is_live_install() {
	( rogentos_is_text_install || rogentos_is_gui_install ) && return 0
	return 1
}

rogentos_is_mce() {
	local _is_mce=$(cat /proc/cmdline | grep sabayonmce)
	if [ -n "${_is_mce}" ]; then
		return 0
	else
		return 1
	fi
}

rogentos_is_normal_boot() {
	if ! rogentos_is_mce && ! rogentos_is_live_install; then
		return 0
	else
		return 1
	fi
}

systemd_running() {
	test -d /run/systemd/system
}

openrc_running() {
	test -e /run/openrc/softlevel
}

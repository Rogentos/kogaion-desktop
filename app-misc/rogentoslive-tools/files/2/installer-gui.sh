#!/bin/bash

. /sbin/rogentos-functions.sh

if rogentos_is_gui_install; then
	rogentos_setup_autologin
	rogentos_setup_gui_installer
fi

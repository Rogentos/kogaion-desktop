#!/bin/bash

. /sbin/rogentos-functions.sh

if rogentos_is_text_install; then
	rogentos_setup_text_installer
fi

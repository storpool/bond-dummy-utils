#!/bin/bash
#
# Copyright (c) 2018, 2021  StorPool
# All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License, version 2,
# as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#
# This tool is inspired by similar tools in the fedora-sysv/initscripts
# package which carry the following copyright notice:
#
# Copyright (c) 1996-2014 Red Hat, Inc. all rights reserved.

. /etc/init.d/functions

cd /etc/sysconfig/network-scripts
. ./network-functions

CONFIG="$1"

need_config "${CONFIG}"

source_config

if [ -z "$NAME" ]; then
	if [ -z "${DEVICE}" ]; then
		# NAME empty get from CONFIG
		NAME="${CONFIG##*-}"
	fi
	NAME="${DEVICE}"
fi

if [ "${SLAVE}" = yes -a "${ISALIAS}" = no -a "${MASTER}" != "" ]; then
	# get all dummy files for master
	DUMMYFILES="$(grep -El "^MASTER=.*${MASTER}" ./ifcfg-dummy*)"
	for DUMMY in ${DUMMYFILES}; do
		DUMMYNAME="${DUMMY##*-}"
		if [ "$DUMMYNAME" = "$NAME" ]; then
			continue
		fi
		echo 0 > "/sys/class/net/${DUMMYNAME}/carrier"
		/sbin/ifup "$DUMMYNAME"
	done
fi

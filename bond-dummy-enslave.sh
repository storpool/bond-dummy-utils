#!/bin/sh
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

set -e

bond="$1"
dummyname="$2"

if [ ! -d "/sys/class/net/$bond" ]; then
	echo "$dummyname: waiting 60 seconds for $bond to appear" 1>&2
	count=0
	while [ ! -d "/sys/class/net/$bond" ]; do
		sleep 0.1
		count="$((count + 1))"
		if [ "$count" -gt 600 ]; then
			echo "$dummyname: the $bond interface is still not up after 60 seconds, proceeding anyway" 1>&2
			break
		fi
	done
fi

if [ ! -d "/sys/class/net/$dummyname" ]; then
	/sbin/ip link add "$dummyname" type dummy
fi

master_path="$(readlink "/sys/class/net/$dummyname/master" 2>/dev/null || true)"
if [ -n "$master_path" ]; then
	master_device="$(basename -- "$master_path")"
	if [ "$master_device" != "$bond" ]; then
		echo "The $dummyname device already has a master device: $master_device" 1>&2
		exit 1
	fi
else
	echo 0 > "/sys/class/net/${dummyname}/carrier"
	/sbin/ip link set "$dummyname" master "$bond"
fi

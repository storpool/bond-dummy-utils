#!/bin/sh
#
# Copyright (c) 2018  StorPool
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

bond="$1"
dummyname="$2"

/sbin/ip link add "$bond" type bond
/sbin/ip link add "$dummyname" type dummy
/sbin/ip link set "$dummyname" up

count=0
while [ ! -f "/run/network/ifenslave.${bond}" ]; do
	sleep 1
	count=$((count+1))
	if [ "$count" -gt 300 ]; then
		echo 'Waited for more than 5 minutes, bailing out' 1>&2
		break
	fi
done

/sbin/ifenslave "$bond" "$dummyname"

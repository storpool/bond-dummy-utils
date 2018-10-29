#!/bin/bash

. /etc/init.d/functions

cd /etc/sysconfig/network-scripts
. ./network-functions

[ -f ../network ] && . ../network

CONFIG=${1}

need_config "${CONFIG}"

source_config

ip link add $NAME type dummy

if [ "${SLAVE}" = yes -a "${ISALIAS}" = no -a "${MASTER}" != "" ]; then
	install_bonding_driver ${MASTER}
	grep -wq "${DEVICE}" /sys/class/net/${MASTER}/bonding/slaves 2>/dev/null || {
		/sbin/ip link set dev ${DEVICE} down
		echo "+${DEVICE}" > /sys/class/net/${MASTER}/bonding/slaves 2>/dev/null
		echo 0 > /sys/class/net/${MASTER}/slave_${DEVICE}/carrier
	}

	exit 0
fi

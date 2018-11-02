#!/usr/bin/make -f
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

PROGS=		ifup-dummy bond-dummy-add bond-dummy-enslave
MANPAGES=	bond-dummy-add.8.gz bond-dummy-enslave.8.gz

SBINDIR?=	/sbin
SYSCONFDIR?=	/etc
SYSCONFNETDIR?=	${SYSCONFDIR}/sysconfig/network-scripts
MANDIR?=	/usr/share/man/man
MAN8DIR?=	${MANDIR}8

BINOWN?=	root
BINGRP?=	root
BINMODE?=	755

SHAREOWN?=	${BINOWN}
SHAREGRP?=	${BINGRP}
SHAREMODE?=	644

INSTALL?=	install
GZIP?=		gzip -9 -n -c
RM?=		rm -f
FALSE?=		false
MKDIR_P?=	mkdir -p

INSTALL_SCRIPT?=	${INSTALL} -o ${BINOWN} -g ${BINGRP} -m ${BINMODE}
INSTALL_DATA?=		${INSTALL} -o ${SHAREOWN} -g ${SHAREGRP} -m ${SHAREMODE}

COPY_SCRIPT?=		${INSTALL} -m ${BINMODE}

all:		${PROGS} ${MANPAGES}

%:		%.sh
		${COPY_SCRIPT} $< $@ || (${RM} $@; ${FALSE})

%.8.gz:		%.8
		${GZIP} $< > $@ || (${RM} $@; ${FALSE})

install-ifup-dummy:	ifup-dummy
		${MKDIR_P} ${DESTDIR}${SYSCONFNETDIR}
		${INSTALL_SCRIPT} ifup-dummy ${DESTDIR}${SYSCONFNETDIR}/

install-bond-dummy-add:	bond-dummy-add bond-dummy-add.8.gz
		${MKDIR_P} ${DESTDIR}${SBINDIR}
		${INSTALL_SCRIPT} bond-dummy-add ${DESTDIR}${SBINDIR}/

		${MKDIR_P} ${DESTDIR}${MAN8DIR}
		${INSTALL_DATA} bond-dummy-add.8.gz ${DESTDIR}${MAN8DIR}/

install-bond-dummy-enslave:	bond-dummy-enslave bond-dummy-enslave.8.gz
		${MKDIR_P} ${DESTDIR}${SBINDIR}
		${INSTALL_SCRIPT} bond-dummy-enslave ${DESTDIR}${SBINDIR}/

		${MKDIR_P} ${DESTDIR}${MAN8DIR}
		${INSTALL_DATA} bond-dummy-enslave.8.gz ${DESTDIR}${MAN8DIR}/

install-debian:	install-bond-dummy-enslave

install-redhat:	install-ifup-dummy install-bond-dummy-add

install:
		if [ -f /etc/debian_version ] || [ -n "$$INSTALL_DEBIAN" ]; then \
			if [ -z "$$SKIP_INSTALL_DEBIAN" ]; then \
				${MAKE} install-debian; \
			fi; \
		fi
		if [ -f /etc/redhat-release ] || [ -n "$$INSTALL_REDHAT" ]; then \
			if [ -z "$$SKIP_INSTALL_REDHAT" ]; then \
				${MAKE} install-redhat; \
			fi; \
		fi

clean:
		${RM} ${PROGS} ${MANPAGES}

.PHONY:		\
		install-ifup-dummy \
		install-bond-dummy-add \
		install-bond-dummy-enslave \
		all install install-debian install-redhat clean

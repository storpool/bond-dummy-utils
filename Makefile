#!/usr/bin/make -f
#
# Copyright (c) 2018  StorPool
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

PROGS=		ifup-dummy bond-dummy-add
MANPAGES=	bond-dummy-add.8.gz

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

install:	install-ifup-dummy install-bond-dummy-add

clean:
		${RM} ${PROGS} ${MANPAGES}

.PHONY:		\
		install-ifup-dummy \
		install-bond-dummy-add \
		all install clean

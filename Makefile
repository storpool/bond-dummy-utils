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

PROG=		ifup-dummy
SRC=		${PROG}.sh

SYSCONFDIR?=	/etc
SYSCONFNETDIR?=	${SYSCONFDIR}/sysconfig/network-scripts

BINOWN?=	root
BINGRP?=	root
BINMODE?=	755

INSTALL?=	install
RM?=		rm -f
FALSE?=		false
MKDIR_P?=	mkdir -p

INSTALL_SCRIPT?=	${INSTALL} -o ${BINOWN} -g ${BINGRP} -m ${BINMODE}

all:		${PROG}

${PROG}:	${SRC}
		${INSTALL} -m ${BINMODE} ${SRC} ${PROG} || (${RM} ${PROG}; ${FALSE})

install:	all
		${MKDIR_P} ${DESTDIR}${SYSCONFNETDIR}
		${INSTALL_SCRIPT} ${PROG} ${DESTDIR}${SYSCONFNETDIR}/

clean:
		${RM} ${PROG}

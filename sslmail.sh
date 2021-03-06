#!/bin/bash
# OpenMAGIC v0.3
#
# OpenSSL TLS heartbeat read overrun (CVE-2014-0160)
# Written by Francesco `ascii` Ongaro - 20140218
# (C) ISGroup SRL - http://www.isgroup.biz
#
# 10-04-2014 Frodo Larik
# - Check all MX records of a domain
# - Sort by MX priority
# - Require domainname as argument
#
# 11-04-2014 Francesco Ongaro
# - Refactoring and bump to 0.3

. ./common.sh

if [ $# -lt 1 ]; then
	echo "Usage: $0 domain"
	exit 0
fi

DOMAIN=$1

mx $DOMAIN | while read PRIO HOST; do
	echo "# [MX    ] $PRIO $HOST ($DOMAIN)"
	for PORT in 465 585 993 995; do
		echo "# [MXPORT] $HOST $PORT ($DOMAIN)"
		./ssltest.sh $HOST $PORT
	done
done

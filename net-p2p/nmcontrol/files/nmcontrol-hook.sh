#!/bin/bash

DEV_NAME="$1"
NM_ACTION="$2"

if [[ ${NM_ACTION} == "up" ]]; then
    [[ -z `rc-status | grep nmcontrol` ]] && return 0
    CONFIG=/etc/nmcontrol/service-dns.conf
    DNS_SERVERS=
    for srv in `nmcli -t -f IP4.DNS con show ${DEV_NAME}`; do
	DNS_SERVERS="${DNS_SERVERS}`echo $srv | cut -d ':' -f 2`,"
    done
    if [[ ! -z ${DNS_SERVERS} ]]; then
	sed -i -e "s|;?\(resolver=\).*|\1${DNS_SERVERS}|g" ${CONFIG}
	nmcli device mod ${DEV_NAME} ipv4.dns 127.0.0.1
    fi

    if [[ -z `grep '^disable_standard_lookups=0' ${CONFIG}` ]]; then
	echo 'disable_standard_lookups=0' >> ${CONFIG}
    fi
fi

#!/bin/bash

if [ ! $# -eq 2 ]; then
    echo "Must provide action (up/down and wg interface)"
    exit 1
fi

IPT="/sbin/iptables"

IN_IFACE="enX0"                   # NIC connected to the internet

ACTION=$1
WG0=$2

set -x

case $ACTION in
    up)
	echo "Post Up tables setup"
        $IPT -A FORWARD -i $WG0 -j ACCEPT
        $IPT -A FORWARD -o $WG0 -j ACCEPT
        $IPT -t nat -A POSTROUTING -o $IN_IFACE -j MASQUERADE
    ;;
    down)
	echo "Post Down tables removal"
        $IPT -t nat -D POSTROUTING -o $IN_IFACE -j MASQUERADE
        $IPT -D FORWARD -o $WG0 -j ACCEPT
        $IPT -D FORWARD -i $WG0 -j ACCEPT        
    ;;
    *)
        echo "unknown action"
        exit 1
    ;;
esac

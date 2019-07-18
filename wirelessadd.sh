#!/bin/bash

MAC_ADDR=$(cat /sys/class/net/wlan0/address)

/sbin/iw phy phy0 interface add ap0 type __ap
/bin/ip link set ap0 address $MAC_ADDR

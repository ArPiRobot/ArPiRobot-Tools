#!/bin/bash

echo "Stopping networking services..."
systemctl stop dnsmasq.service
systemctl stop dhcpcd.service
systemctl stop hostapd.service

echo "Removing ap0 adapter..."
#sysctl net.ipv4.ip_forward=0
iw dev ap0 del

echo "Starting necessary network services..."
systemctl start dhcpcd.service

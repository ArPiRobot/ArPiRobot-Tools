#!/bin/bash

ifdown --force wlan0 && ifdown --force ap0 && ifup ap0 && ifup wlan0
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -s 192.168.10.0/24 ! -d 192.168.10.0/24 -j MASQUERADE
systemctl restart dnsmasq
systemctl restart hostapd
systemctl restart wpa_supplicant

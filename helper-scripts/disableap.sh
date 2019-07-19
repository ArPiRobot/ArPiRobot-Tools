#!/bin/bash

service hostapd stop
service dnsmasq stop
ifdown --force ap0
ifdown --force wlan0
ifup wlan0

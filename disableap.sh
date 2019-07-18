#!/bin/bash

service hostapd stop
service dnsmasq stop
ifdown --force ap0

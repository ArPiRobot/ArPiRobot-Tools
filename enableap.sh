#!/bin/bash

service hostapd start
service dnsmasq start
ifup ap0

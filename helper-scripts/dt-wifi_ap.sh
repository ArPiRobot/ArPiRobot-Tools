#!/bin/bash

# Read SSID and password from file
SSID_LINE=$(cat /etc/hostapd/hostapd.conf | grep ssid)
PASS_LINE=$(cat /etc/hostapd/hostapd.conf | grep wpa_passphrase)
SSID=$(echo $SSID_LINE | sed -z 's/ssid=//g')
PASS=$(echo $PASS_LINE | sed -z 's/wpa_passphrase=//g')

# If no arguments print the current SSID then the current password (WPA2)
if [ $# -eq 0 ]; then
    echo $SSID
    echo $PASS
    exit 0
else
    if [ $# -ne 2 ]; then
        echo "Either call with zero or two arguments!"
        echo "$0 [NEW_SSID NEW_PASSWORD]"
        exit 1
    fi
fi

NEW_SSID="$1"
NEW_PASS="$2"

# Don't use sed as it would require escaping symbols like $, @, /, etc. Python  script is used instead
# sed "s/ssid=$SSID/ssid=$NEW_SSID/g" /etc/hostapd/hostapd.conf
# sed "s/wpa_passphrase=$PASS/wpa_passphrase=$NEW_PASS/g" /etc/hostapd/hostapd.conf

sudo dt-wifi_ap_replace.py "$1" "$2"

#!/bin/bash

# Fix permissions on file just in case (this was a problem on older images)
sudo chmod 755 /etc/wpa_supplicant/wpa_supplicant.conf

# Read SSID and password from file
SSID_LINE=$(cat /etc/wpa_supplicant/wpa_supplicant.conf | grep ssid)
PASS_LINE=$(cat /etc/wpa_supplicant/wpa_supplicant.conf | grep psk)
SSID=$(echo $SSID_LINE | sed -z 's/ssid=//g' | sed -z 's/"//g')
PASS=$(echo $PASS_LINE | sed -z 's/psk=//g' | sed -z 's/"//g')

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

sudo dt-wifi_client_replace.py "$1" "$2"

#!/bin/bash

# Fix permissions just in case
sudo chmod 755 /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null 2>&1
sudo chmod 755 /etc/hostapd/hostapd.conf > /dev/null 2>&1

# Read data from files
AP_COUNTRY_LINE=$(cat /etc/hostapd/hostapd.conf | grep country_code=)
# If no country code set assume US (default hostapd.conf file written by image script does not have this line so need to make some assumption)
if [ -z "$AP_COUNTRY_LINE" ]; then
    AP_COUNTRY_LINE="country_code=US"
fi
AP_CHANNEL_LINE=$(cat /etc/hostapd/hostapd.conf | grep channel=)
CLIENT_CODE_LINE=$(cat /etc/wpa_supplicant/wpa_supplicant.conf | grep country=)

AP_COUNTRY=$(echo "$AP_COUNTRY_LINE" | sed -z 's/country_code=//g')
AP_CHANNEL=$(echo "$AP_CHANNEL_LINE" | sed -z 's/channel=//g')
CLIENT_COUNTRY=$(echo "$CLIENT_CODE_LINE" | sed -z 's/country=//g')

# If no arguments passed print the current info

if [ $# -eq 0 ]; then
    printf "$AP_COUNTRY\n$AP_CHANNEL\n$CLIENT_COUNTRY\n"
    exit 0
else
    if [ $# -ne 3 ]; then
	echo "Either call with zero or three arguments!"
	echo "$0 [AP_COUNTRY AP_CHANNEL CLIENT_COUNTRY]"
	exit 1
    fi
fi

# New AP Country = $1
# New AP Channel = $2
# New Client Country = $3

sudo dt-advancedwifi_replace.py "$1" "$2" "$3"

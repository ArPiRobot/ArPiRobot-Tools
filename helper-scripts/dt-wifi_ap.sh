#!/bin/bash
#####################################################################################
#
# Copyright 2020 Marcus Behel
#
# This file is part of ArPiRobot-Tools.
# 
# ArPiRobot-Tools is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# ArPiRobot-Tools is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with ArPiRobot-Tools.  If not, see <https://www.gnu.org/licenses/>.
#####################################################################################
# script:      dt-wifi_ap.sh
# description: Get or set WiFi Access Point (AP) settings. If configuring settings
#              the python script by the same name is used.
# author:      Marcus Behel
# version:     v1.0.0
#####################################################################################

# Fix file permissions (this was an issue on older images)
sudo chmod 755 /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null 2>&1

# Read SSID and password from file
SSID_LINE=$(cat /etc/hostapd/hostapd.conf | grep -w ssid)
PASS_LINE=$(cat /etc/hostapd/hostapd.conf | grep wpa_passphrase=)
COUNTRY_LINE=$(cat /etc/hostapd/hostapd.conf | grep country_code=)
CHANNEL_LINE=$(cat /etc/hostapd/hostapd.conf | grep channel=)
SSID=$(echo "$SSID_LINE" | sed -z 's/ssid=//g')
PASS=$(echo "$PASS_LINE" | sed -z 's/wpa_passphrase=//g')
COUNTRY=$(echo "$COUNTRY_LINE" | sed -z 's/country_code=//g')
CHANNEL=$(echo "$CHANNEL_LINE" | sed -z 's/channel=//g')

# If no arguments print the current SSID then the current password (WPA2)
if [ $# -eq 0 ]; then
    echo "$SSID"
    echo "$PASS"
    echo "$COUNTRY"
    echo "$CHANNEL"
    exit 0
else
    if [ $# -ne 4 ]; then
        echo "Either call with zero or four arguments!"
        echo "$0 [NEW_SSID NEW_PASSWORD COUNTRY_CODE CHANNEL]"
        exit 1
    fi
fi

NEW_SSID="$1"
NEW_PASS="$2"

# Don't use sed as it would require escaping symbols like $, @, /, etc. Python  script is used instead
# sed "s/ssid=$SSID/ssid=$NEW_SSID/g" /etc/hostapd/hostapd.conf
# sed "s/wpa_passphrase=$PASS/wpa_passphrase=$NEW_PASS/g" /etc/hostapd/hostapd.conf

sudo dt-wifi_ap_replace.py "$1" "$2" "$3" "$4"

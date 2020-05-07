#!/usr/bin/python3

import sys
import fileinput

# four args plus name of script
# dt-wifi_ap_replace.py SSID PASSWORD COUNTRY_CODE CHANNEL
if len(sys.argv) != 5:
    print("Must be exactly four arguments!")
    sys.exit(1)

with fileinput.FileInput("/etc/hostapd/hostapd.conf", inplace=True, backup='.bak') as file:
    for line in file:
        if line.startswith("ssid="):
            print("ssid=" + sys.argv[1])
        elif line.startswith("wpa_passphrase="):
            print("wpa_passphrase=" + sys.argv[2])
        elif line.startswith("country_code="):
            print("country_code=" + sys.argv[3])
        elif line.startswith("channel="):
            print("channel=" + sys.argv[4])
        else:
            print(line, end='')

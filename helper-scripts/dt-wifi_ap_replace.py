#!/usr/bin/python3

import sys
import fileinput
import os

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

if os.path.exists("/etc/wpa_supplicant/wpa_supplicant.conf"):
    with fileinput.FileInput("/etc/wpa_supplicant/wpa_supplicant.conf", inplace=True, backup='.bak') as file:
        for line in file:
            if line.startswith("country="):
                print("country=" + sys.argv[3])
            else:
                print(line, end='')

if os.path.exists("/etc/default/crda"):
    with fileinput.FileInput("/etc/default/crda", inplace=True, backup=".bak") as file:
        for line in file:
            if line.startswith("REGDOMAIN="):
                print("REGDOMAIN={}".format(sys.argv[3]))
            else:
                print(line, end='')

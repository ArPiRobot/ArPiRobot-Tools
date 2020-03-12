#!/usr/bin/python3

import sys
import fileinput

# Three args (ap country, ap channel, client country) plus name of script
if len(sys.argv) != 4:
    print("Must be exactly three arguments!")
    sys.exit(1)

with fileinput.FileInput("/etc/hostapd/hostapd.conf", inplace=True, backup='.bak') as file:
    for line in file:
        if line.startswith("country_code="):
            print("country_code=" + sys.argv[1])
        elif line.startswith("channel="):
            print("channel=" + sys.argv[2])
        else:
            print(line, end='')

with fileinput.FileInput("/etc/wpa_supplicant/wpa_supplicant.conf", inplace=True, backup='.bak') as file:
    for line in file:
        if line.startswith("country="):
            print("country=" + sys.argv[3])
        else:
            print(line, end='')


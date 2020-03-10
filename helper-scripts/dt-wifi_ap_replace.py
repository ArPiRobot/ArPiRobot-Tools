#!/usr/bin/python3

import sys
import fileinput

# Two args plus name of script
if len(sys.argv) != 3:
    print("Must be exactly two arguments!")
    sys.exit(1)

with fileinput.FileInput("/etc/hostapd/hostapd.conf", inplace=True, backup='.bak') as file:
    for line in file:
        if line.startswith("ssid="):
            print("ssid=" + sys.argv[1])
        elif line.startswith("wpa_passphrase="):
            print("wpa_passphrase=" + sys.argv[2])
        else:
            print(line, end='')

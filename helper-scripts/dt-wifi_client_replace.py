#!/usr/bin/python3

import sys

# Two args plus name of script
if len(sys.argv) != 3:
    print("Must be exactly two arguments!")
    sys.exit(1)

template_wpa = "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev\nupdate_config=1\ncountry=US\n\nnetwork={\n     ssid=\"%SSID_HERE%\"\n     psk=\"%PSK_HERE%\"\n     key_mgmt=WPA-PSK\n}"
template_open = "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev\nupdate_config=1\ncountry=US\n\nnetwork={\n     ssid=\"%SSID_HERE%\"\n     key_mgmt=NONE\n}"

text = ""

if sys.argv[2] != "":
    text = template_wpa
    text = text.replace("%SSID_HERE%", sys.argv[1])
    text = text.replace("%PSK_HERE%", sys.argv[2])
else:
    text = template_open
    text = text.replace("%SSID_HERE%", sys.argv[1])

f = open("/etc/wpa_supplicant/wpa_supplicant.conf", "w")
f.write(text)
f.close()

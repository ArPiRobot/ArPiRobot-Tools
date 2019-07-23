# New WiFi Setup Process
WiFi station and AP mode for arpirobot robots.

Tested and working on Pi 3A+ and Pi Zero W.

## Install Required Software
```
sudo apt install hostapd dnsmasq
```

## Edit Configurations

Backup the original config.
```
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
```

Edit `/etc/dnsmasq.conf`. Add the following contents.
```
interface=lo,ap0
server=8.8.8.8
domain-needed
bogus-priv
dhcp-range=192.168.10.2,192.168.10.10,255.255.255.0,24h
```

Edit `/etc/dhcpcd.conf`. Add the following
```
interface ap0
static ip_address=192.168.10.1
nohook wpa_supplicant
```

Edit `/etc/hostapd/hostapd.conf`
```
channel=11
ssid=AP_SSID
wpa_passphrase=AP_PASSWORD
interface=ap0
hw_mode=g
macaddr_acl=0
auth_algs=1
wpa=2
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
driver=nl80211
```

Edit `/etc/default/hostapd`. Add the following line (or change an existing `DAEMON_CONF` line)
```
DAEMON_CONF="/etc/hostapd/hostapd.conf"
```

## Disable network services on boot
These must be started in a specific order. The custom `arpirobot-networking` service will take care of this.

```
sudo systemctl stop hostapd
sudo systemctl stop dnsmasq
sudo systemctl stop dhcpcd
sudo systemctl disable hostapd
sudo systemctl disable dnsmasq
sudo systemctl disable dhcpcd
```

## Setup custom networking service
This service is responsible for managing the custom network setup. Starting the service will configure the pi to connect to a network (station mode) and host an AP (ap mode) at the same time. Stopping the service will disable AP mode, however it will still connect to an existing network (station mode) if a known one is in range.

Install the service and required scripts.
```
sudo ln ./wifistart.sh /usr/local/bin/wifistart.sh
sudo ln ./wifistop.sh /usr/local/bin/wifistop.sh
sudo ln ./dowifistart.sh /usr/local/bin/dowifistart.sh
sudo cp ./arpirobot-networking.service /lib/systemd/system/
sudo sytemctl enable arpirobot-networking.service
```

## Reboot and make sure everything starts
The service will "complete" immediatly when started, but the setup process will continue in the background. This keeps it from holding up the boot process, but it may take a little time after booting for the networking to become active.

Network status can be checked with
```
ip -h addr
```

The output will look similar to the following if everything is working properly
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether aa:bb:cc:dd:ee:ff brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.17/24 brd 192.168.0.255 scope global wlan0
       valid_lft forever preferred_lft forever
    inet6 fd32:e504:54f8::167/128 scope global noprefixroute dynamic
       valid_lft 85192sec preferred_lft 85192sec
    inet6 fd32:e504:54f8:0:5562:1325:95ab:5ea9/64 scope global mngtmpaddr noprefixroute dynamic
       valid_lft 7181sec preferred_lft 1781sec
    inet6 fe80::b388:22f1:1a87:d42f/64 scope link
       valid_lft forever preferred_lft forever
7: ap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether aa:bb:cc:dd:ee:ff brd ff:ff:ff:ff:ff:ff
    inet 192.168.10.1/24 brd 192.168.10.255 scope global ap0
       valid_lft forever preferred_lft forever
    inet6 fe80::ba27:ebff:fe0d:1a8c/64 scope link
       valid_lft forever preferred_lft forever
```

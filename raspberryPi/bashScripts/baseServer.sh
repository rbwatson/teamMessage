#!/bin/bash
# Bash script to run after initial OS install
#  This script configures the base networking and
#  file services for the Raspbery Pi to later run
#  as a web server.
#
#	curl --silent "http://<Server>/raspi/bashScripts/baseServer.sh" | sudo sh
#	curl --silent "http://192.165.1.101/raspi/bashScripts/baseServer.sh" | sudo sh
#
#++++
#  check for root access
#----
if [ `whoami` != "root" ]
then
  echo "This install must be run as root or with sudo."
  exit
fi
#++++s
#  update the base OS distribution
#----
echo "updating OS"
apt-get update
#++++
#	update /etc/network/interfaces
#	  to use fixed IP on Ethernet
#     and DHCP on wireless
#----
echo "Configuring network interfaces"
cat - > /etc/network/interfaces <<NETWORKIFACE
auto lo

iface lo inet loopback

iface eth0 inet static
address 192.165.1.64
netmask 255.255.255.0
gateway 192.165.1.1


allow-hotplug wlan0
iface wlan0 inet static
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
address 192.165.1.65
netmask 255.255.255.0
gateway 192.165.1.1

NETWORKIFACE
#++++
#	update  /etc/wpa_supplicant/wpa_supplicant.conf
#	  to use wireless network and password configured for router
#----
echo "Configuring WiFi connections"
cat - > /etc/wpa_supplicant/wpa_supplicant.conf <<WIFICONFIG
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
ssid="IHS-Field1"
psk="IhsOfMn2014"

# Protocol type can be: RSN (for WP2) and WPA (for WPA1)
proto=WPA

# Key management type can be: WPA-PSK or WPA-EAP (Pre-Shared or Enterprise)
key_mgmt=WPA-PSK

# Pairwise can be CCMP or TKIP (for WPA2 or WPA1)
pairwise=CCMP TKIP
group=CCMP TKIP

#Authorization option should be OPEN for both WPA1/WPA2 (in less commonly used are SHARED and LEAP)
auth_alg=OPEN
}

WIFICONFIG

#++++
#  install NTFS for USB drives
#----
echo "Installing NTFS file system"
apt-get install ntfs-3g
#++++
#  install the DNS server
#----
echo "Installing DNS server: dnsmasq"
apt-get install -y dnsmasq
#++++
#  configure the DNS server 
#----
echo "Configuring DNS server: dnsmasq"
cat - > /etc/dnsmasq.conf <<DNSMASQCONF
# Dnsmasq.conf for raspberry pi
# adapted from: Stephen Wood heystephenwood.com

domain-needed

interface=eth0

#resolv-file=/etc/resolv.dnsmasq.conf
#listen-address=127.0.0.1

# Set up your local domain here
address=/raspi.local/192.165.1.64
address=/www.raspi.local/192.165.1.64#80
address=/ftp.raspi.local/192.165.1.64#21
address=/sftp.raspi.local/192.165.1.64#22
domain=raspi.local

server=192.165.1.1
server=8.8.8.8

# Max cache size dnsmasq can give us, and we want all of it!
cache-size=10000

#no DHCP from dnsmasq
no-dhcp-interface=

DNSMASQCONF

#++++
#	configure /etc/resolv.conf to use:
#		localhost
#		server's fixed IP
#----
echo "Configuring nameservers"
cat - > /etc/resolv.conf <<LOCALNAMESERVERS
nameserver 192.165.1.64
nameserver 192.165.1.1
nameserver 8.8.8.8

LOCALNAMESERVERS

#++++
#  restart service to use new settings
#----
echo "Restarting DNS server to pick up new configuration"
service dnsmasq restart
#++++
#  Install DNS tools
#----
echo "Installing DNS tools"
apt-get install -y dnsutils
#++++
#  Exit message
#----
echo "Reboot to apply changes."

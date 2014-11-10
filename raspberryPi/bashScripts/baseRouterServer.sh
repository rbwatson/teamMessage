#!/bin/bash
# Bash script to run after initial OS install
#  This script configures the base networking and
#  file services for the Raspbery Pi to later run
#  as a web server.
#
#	curl --silent "http://<Server>/raspi/bashScripts/baseRouterServer.sh" | sudo sh
#	curl --silent "http://192.165.1.101/raspi/bashScripts/baseRouterServer.sh" | sudo sh
#
#++++
#  check for root access
#----
if [ `whoami` != "root" ]
then
  echo "This install must be run as root or with sudo."
  exit
fi
#++++
# name the device
#  change "raspberrypi" to whatever you want to name it
#----
cat - > /etc/hostname <<HOSTNAME

raspberrypi

HOSTNAME
#++++
#  update the base OS distribution
#----
echo "updating OS"
apt-get update
#++++
#	Get the Router-related bits
#----
#apt-get install isc-dhcp-server
#++++
#	update /etc/network/interfaces
#	  to use fixed IP on Ethernet
#     and DHCP on wireless
#----
echo "Configuring network interfaces"
cat - > /etc/network/interfaces <<NETWORKIFACE
# loopback interface
auto lo
iface lo inet loopback

# wired ethernet
auto eth0
allow-hotplug eth0
iface eth0 inet static
	address 192.165.1.64
	netmask 255.255.255.0
	gateway 192.165.1.1


auto wlan0
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
apt-get install wpasupplicant wireless-tools
#
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
#  restart service to use new settings
#----
#echo "Restarting DNS server to pick up new configuration"
#service dnsmasq restart
#++++
#  Install DNS tools
#----
echo "Installing DNS tools"
apt-get install -y dnsutils
#++++
#  Exit message
#----
echo "Reboot to apply changes."

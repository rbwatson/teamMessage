#!/bin/bash
# Bash script to run after initial OS install
#  This script configures the base networking and
#  file services for the Raspbery Pi to later run
#  as a web server.
#
#	curl --silent "http://<Server>/raspi/bashScripts/baseServerNoWiFi.sh" | sudo sh
#	curl --silent "http://192.165.1.101/raspi/bashScripts/baseServerNoWiFi.sh" | sudo sh
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

auto eth0
allow-hotplug eth0
iface eth0 inet static
address 192.165.1.64
netmask 255.255.255.0
gateway 192.165.1.1

NETWORKIFACE

#++++
#  install NTFS for USB drives
#----
echo "Installing NTFS file system"
apt-get install ntfs-3g

#++++
#  Install DNS tools
#----
echo "Installing DNS tools"
apt-get install -y dnsutils
#++++
#  Exit message
#----
echo "Reboot to apply changes."

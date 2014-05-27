#!/bin/bash
# Bash script to run after initial OS install
#  This script configures the base networking and
#  file services for the Raspbery Pi to later run
#  as a web server.
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
#  update the base OS distribution
#----
echo "updating OS"
apt-get update
#++++
#  TODO:
#	update /etc/network/interfaces
#	  to use fixed IP on Ethernet
#----

#++++
#  TODO:
#	update  /etc/wpa_supplicant/wpa_supplicant.conf
#	  to use wireless network and password configured for router
#----


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
# Set up your local domain here
domain=raspi.local
#resolv-file=/etc/resolv.dnsmasq
min-port=4096
#server=8.8.8.8
#server=8.8.4.4

# Max cache size dnsmasq can give us, and we want all of it!
cache-size=10000

#no DHCP from dnsmasq
no-dhcp-interface=

# Below are settings for dhcp. Comment them out if you dont want
# dnsmasq to serve up dhcpd requests.
# dhcp-range=192.168.0.100,192.168.0.149,255.255.255.0,1440m
# dhcp-option=3,192.168.0.1
# dhcp-authoritative

DNSMASQCONF

#++++
#  TODO:
#	configure /etc/resolv.conf to use:
#		localhost
#		server's fixed IP
#----


#++++
#  restart service to use new settings
#----
echo "Restarting DNS server to pick up new configuration"
service dnsmasq restart
#++++
#  restart service to use new settings
#----
echo "Installing DNS tools"
apt-get install -y dnsutils
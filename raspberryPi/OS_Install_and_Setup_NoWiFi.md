# Setup and Installation #

This document describes how to setup and install the local message server software on a Raspberry Pi (RasPi) for installations that use an external router/WiFi access point.

## Required equipment and software ##

1. Raspberry PI
	1. Raspberry Pi board
	2. Case
	4. 16GB or larger SDHC memory card (Note that the web server required the fastest chip you can find/afford.
	3. USB Keyboard (for Dev)
	5. HDMI monitor and cable (for Dev)
6. External WiFi Router with at least 1 LAN Ethernet port
7. Cat 5/6 cables (at least 1 to go between router & Raspberry Pi
8. A SSH terminal
	1. PuTTY on the PC
	2. The **Term** program on the Mac
3. A *host* computer that can access the GitHub files used to configure the RasPi.
	* This computer must be on the same local-area network as the RasPi to connect over SSH and download files to the RasPi.

## Configure the external router ##

1. Set the router's LAN address to be 192.165.1.1
2. Set the router's Device name to something meaningful
2. Set the router to be a DHCP server
3. Assign IP addresses from 192.165.1.101 to 192.165.1.255
	* This will leave 192.165.1.2 to 192.165.1.100 for  static IP addresses
3. Set WiFi SSID and Channel (**Auto** will probably be fine)
4. Set Security to **WPA-PSK**
5. Set the passphrase

## Install the software on the Raspberry Pi##

2. Load the latest basic Raspbian Wheezy distribution image onto the SDHC card
	* On windows, use **Win32 Disk Imager** tool
3. Connect router to network and turn it on
	* the installation will load more files from the Internet
1. Connect keyboard to RasPi
2. Connect monitor to RasPi
2. Connect RasPi to router
1. After the OS is loaded onto the SDHC card, insert the SDHC card into RasPi and apply power
	* Let it initialize to the raspi-config screen

## Initialize the OS installation
1. In the raspi-config screen:
	1. Select option **8. Advanced options**
		* Select option **A7 Update** to update the raspi-config tool
	3. When it's done, it'll return to the raspi-config screen
4. In the raspi-config screen:
	1. Select option **1. Expand filesystem**, then Enter
	2. Select option **3. Enable boot to desktop**, then Enter
		* Ensure the first option is selected, then Enter
	2. Select option **8. Advanced options**
		* Select option **A1 Overscan**, select **Enable**, and then Enter
	2. Select option **8. Advanced options**
		* Select option **A4 SSH**, select **Enable**, and then Enter
	1. Select **<Finish\>**, Enter, and then **<Yes>** to reboot

## Install the base networking software ##
This step configures the basic networking software on the RasPi.

1. Read the IP address of the RasPi on the monitor
2. Open a SSH window on the host computer using the IP address read from the previous step
	* Accept the certificate warning, if you get one
3. In the SSH window:
	* **login as:** pi 
	* **pi@192.xx.xx.xx's password:** raspberry
		* note the password characters aren't shown as you type them.
1. Find the IP address of the host computer
	* in this example, I'll use **192.1.1.101** for the host's IP address. Be sure to substitute your host's address in your installation. 
1. Run the ```baseServerNoWiFi.sh``` file in the ```bashScripts``` folder.
	* If your host has a web server, you can run the script from the Raspberry Pi by using **curl** by calling this line from your SSH window 
```
	curl --silent "https://github.com/rbwatson/teamMessage/blob/master/raspberryPi/bashScripts/baseServerNoWiFi.sh" | sudo sh
```
1. If you had no errors, reboot the RasPi
	* 
```
$ sudo reboot
```
## Status check ##

At this point the RasPi should have the basic networking software loaded and have static IP address and it should be functioning as the router's DNS nameserver. To test this, try to ping the RasPi by using its domain name: ```raspi.local```

1. From a CMD (or Term) window on your host computer, try this command: 
	* ```ping 192.165.1.64```
1. You should get a response that repeats
	* ```Reply from 192.165.1.64: bytes=32 time=2ms TTL=64```
1. Then try pinging an external website from the Raspberry Pi. From the SSH window, ping a popular site, such as google.com
	* ```ping google.com```
1. If that doesn't work, the troubleshoot the RasPi networking configuration from its hard-wired terminal (keyboard and monitor)
2. If both ping tests pass, then your Raspberry Pi has a connection that works in both directions.

## Load the web-server software ##
These steps load the web server software. 

1. Open a SSH window on the host computer and connect to the Raspberry Pi
	* Accept the certificate warning, if you get one
1. In the SSH window:
	* **login as:** pi 
	* **pi@192.xx.xx.xx's password:** raspberry
		* note the password characters aren't shown as you type them.
1. Run the ```lampStack.sh``` file from the ```bashScripts``` folder.
	* If your host has a web server, you can run the script using **curl** by calling this line from your SSH window 
```
	curl --silent "https://github.com/rbwatson/teamMessage/blob/master/raspberryPi/bashScripts/lampStack.sh" | sudo sh
```
	* **Note** Apache and MySql will prompt you for several passwords. Be sure you don't lose them! 
	* Configure **PhpMyAdmin** for only **apache2** when prompted.
	* In the **Configuring phpmyadmin** dialog, select **<Yes>**
1. If you had no errors, from the SSH window, reboot the Raspberry Pi
	* 
```
$ sudo reboot
```
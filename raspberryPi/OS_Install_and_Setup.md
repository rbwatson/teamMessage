# Setup and Installation #

This document describes how to setup and install the local message server software on a Raspberry Pi (RasPi).

## Required equipment and software ##

1. Raspberry PI
	1. Raspberry Pi board
	2. Case
	4. 16GB or larger SDHC memory card
	3. USB Keyboard (for Dev)
	5. HDMI monitor and cable (for Dev)
6. WiFi Router
7. Cat 5/6 cables (at least 1 to go between router & Raspberry Pi
8. A SSH terminal
	1. PUTTY on the PC
	2. the **Term** program on the Mac
3. A *host* computer that can access the GitHub files used to configure the RasPi.
	* This computer must be on the same network as the RasPi to connect over SSH and download files to the RasPi.

## Configure the router ##

1. Set the router's LAN address to be 192.165.1.1
1. Set the router to be a DHCP server
	1. assign IP addresses from 192.165.1.101 to 192.165.1.255
		* this will leave 192.165.1.2 to 192.165.1.100 for use as static IP addresses
1. Set the router to use manually assigned DNS server addresses
	1. Set the 1st DNS server address to be 192.165.1.64 (this will be the RasPi's address after it's been configured)
	2. Set the 2nd DNS server address to be an external DNS server if the router will be connected to the Internet. For example, 8.8.8.8



## Install the Base OS ##

2. Connect RasPi to router
3. Connect router to network
	* the installation will load more files from the Internet
1. Connect keyboard to RasPi
2. Connect monitor to RasPi
2. Load Raspbian Wheezy distribution onto SDHC card
	* On windows, use **Win32 Disk Imager** tool
1. After the OS is loaded, insert SDHC card into RasPi and apply power
	* Let it initialize to the raspi-config screen
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
	1. Select **<Finish>**, Enter, and then **<Yes>** to reboot

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
1. Run the ```baseServer.sh``` file in the ```bashScripts``` folder.
	* If your host has a web server, you can run the script using **curl** by calling this line from your SSH window 
```
	curl --silent "https://github.com/rbwatson/teamMessage/blob/master/raspberryPi/bashScripts/baseServer.sh" | sudo sh
```
1. If you had no errors, reboot the RasPi
	* 
```
$ sudo reboot
```
## Status check ##

At this point the RasPi should have the basic networking software loaded and have static IP address and it should be functioning as the router's DNS nameserver. To test this, try to ping the RasPi by using its domain name: ```raspi.local```

1. From a CMD (or Term) window on your host computer, try this command: 
	* ```ping raspi.local```
1. You should get a response that repeats
	* ```Reply from 192.165.1.64: bytes=32 time=2ms TTL=64```
1. Then try pinging an external website, such as google.com
	* ```ping google.com```
2. If you don't get a reply, or you get an error that it couldn't find ```raspi.local```, try rebooting your router so that it will ping the RasPi's DNS nameserver.
2. If that doesn't work, try pinging the RasPi's IP
	* ```ping 192.165.1.64```
1. If that doesn't work, the troubleshoot the RasPi networking configuration from its hard-wired terminal (keyboard and monitor)

## Load more network software ##
This step loads the web server software. 

1. Open a SSH window on the host computer using the RasPi's name: ```raspi.local```
	* Accept the certificate warning, if you get one
1. In the SSH window:
	* **login as:** pi 
	* **pi@192.xx.xx.xx's password:** raspberry
		* note the password characters aren't shown as you type them.
1. Run the ```lampStack.sh``` file in the ```bashScripts``` folder.
	* If your host has a web server, you can run the script using **curl** by calling this line from your SSH window 
```
	curl --silent "https://github.com/rbwatson/teamMessage/blob/master/raspberryPi/bashScripts/lampStack.sh" | sudo sh
```
	* **Note** Apache and MySql will prompt you for several passwords. Be sure you don't lose them! 
	* Configure **PhpMyAdmin** for only **apache2** when prompted.
	* In the **Configuring phpmyadmin** dialog, select **<Yes>**
1. If you had no errors, shutdown the RasPi
	* ```sudo shutdown -h -P 0 x```
1. Restart the router

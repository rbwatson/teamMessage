#!/bin/bash
# Bash script to run after the baseServer.sh script.
#  This script configures the web server programs
#	 Apache
#	 MySQL
#	 PHP5
# 	 FTP
#
#	curl --silent "http://<Server>/raspi/bashScripts/lampStack.sh" | sudo sh
#	curl --silent "http://192.165.1.101/raspi/bashScripts/lampStack.sh" | sudo sh
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
#  Install LAMP stack
#		Apache, PHP, MySQL
#----
#++++
#  Install Apache if it isn't running
#----
pgrep apache2 > /dev/null
if [ $? -eq 0 ]
then
    echo "Apache is installed and running."
else
    echo "Installing Apache"
	apt-get install -y apache2 apache2-doc openssl-blacklist
fi
#++++
#  Install PHP if it doesn't run when called
#----
php --help > /dev/null
if [ $? -eq 0 ]
then
    echo "PHP is installed."
else
	echo "Installing PHP"
	apt-get install -y php5
fi
#++++
#  Install MySQL if it doesn't run when called
#----
MySQL --help > /dev/null
if [ $? -eq 0 ]
then
    echo "MySQL is installed and running."
else
	echo "Installing MySQL"
	apt-get install -y mysql-client mysql-server libipc-sharedcache-perl libterm-readkey-perl tinyca libfont-freetype-perl libgtk2-perl-doc
fi
#++++
#  Install PHPmyAdmin x
#----
 apt-get install -y phpmyadmin libmcrypt-dev mcrypt
#++++
#  Install FTP if it isn't running
#----
pgrep ftp > /dev/null
if [ $? -eq 0 ]
then
    echo "FTP is installed and running"
else
	echo "Installing FTP"
	apt-get install -y vsftpd
fi
#++++
#  Create phpinfo page
#----
echo "Creating PHP info page"
cat - > /var/www/phpinfo.php <<PHPINFOTEXT
<?php
phpinfo();
?>
PHPINFOTEXT
#++++
#  Restart the DNS server
#----
echo "Restarting the DNS server"
service dnsmasq restart
#++++
#  Done with this script
#----
echo "Done installing LAMP stack."
echo "Shutdown and restart the Raspberry Pi."

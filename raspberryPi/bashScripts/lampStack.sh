#!/bin/bash
# Bash script to run after the baseServer.sh script.
#  This script configures the web server programs
#	 Apache
#	 MySQL
#	 PHP5
# 	 FTP
#    WordPress
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
#   TODO: edit /etc/php5/apache2/php.ini 
#		to increase max upload file size to 8M
#----

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
#  Done with this script
#----
echo " "
echo " "
echo "Finished installing the web server software."
echo " "
echo "Copy the Wordpress files to /var/www/wp on the Raspberry Pi to complete the installation."
echo "Shutdown and restart the Raspberry Pi, and then copy the Wordpress files."

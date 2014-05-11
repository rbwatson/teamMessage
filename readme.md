## teamMessage ##

A simple messaging system for teams to use on resource-constrained systems, such as a RaspberryPi

# Installation #

Requires: PHP & MySQL



1.  Copy the files in **webroot** to a node on your webserver, such as copy webroot/\*.\* to /var/www/msg/\*.\*
2.  In PHP MySql, run the .sql files in **config** in this order:
	1.    CreateEmptyDatabase.sql
	2.    AddDbUserAccount.sql
	3.    testdata.sql

In general the project files are grouped into these top-level folders:

* **webroot** hosts the files that are installed on the webserver
* **config** holds the files used to build and initialize the database used by the tool.

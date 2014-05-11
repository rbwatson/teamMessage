-- Creates user account for functions used by team message server
-- this account is only used by the code

GRANT USAGE ON *.* TO 'fieldteaminfo'@'localhost' IDENTIFIED BY PASSWORD '*0FE5A744B9EC2612665BCA3EA7A897DAC929A8A1';

GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON `fieldteaminfo`.* TO 'fieldteaminfo'@'localhost';


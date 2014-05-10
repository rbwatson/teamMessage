-- Creates user account for functions used by ihs message server
-- this account is only used by the code

GRANT USAGE ON *.* TO 'ihsClinicInfo'@'localhost' IDENTIFIED BY PASSWORD '*CFD3105F77D8E5344CE4A03FEB4AF98AD980FB39';

GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON `ihsclinicinfo`.* TO 'ihsClinicInfo'@'localhost';


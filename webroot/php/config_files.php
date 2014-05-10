<?php
 if (!defined('IHS_MESSAGE_CONSTANTS')) {
	define('IHS_MESSAGE_CONSTANTS', 'ihs_message_constants', false);

	// Contains paths to files and folders shared by the 
	//  php scripts on the server.	
	// database interfaces
	define('DB_SERVER', 'localhost', false);
	define('DB_USER', 'ihsClinicInfo', false);
	define('DB_PASS', 'ihsData', false);
	define('DB_DATABASE_NAME', 'ihsclinicinfo', false);

    define('DB_TABLE_ACCOUNTS', 'ihsaccounts', false);
    define('DB_TABLE_MESSAGES', 'ihsmessages', false);
    define('DB_TABLE_ROUTES', 'ihsmessageroutes', false);
}	
?>

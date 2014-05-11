<?php
 if (!defined('TEAM_MESSAGE_CONSTANTS')) {
	define('TEAM_MESSAGE_CONSTANTS', 'team_message_constants', false);

	// Contains paths to files and folders shared by the 
	//  php scripts on the server.	
	// database interfaces
	define('DB_SERVER', 'localhost', false);
	define('DB_USER', 'fieldteaminfo', false);
	define('DB_DATABASE_NAME', 'fieldteaminfo', false);
	// TODO: in production, this value should be removed from the project 
	//  because, right now, it's in the public domain
	define('DB_PASS', 'teamData', false);

    define('DB_TABLE_ACCOUNTS', 'teamaccounts', false);
    define('DB_TABLE_MESSAGES', 'teammessages', false);
    define('DB_TABLE_ROUTES', 'teammessageroutes', false);
	define('DB_TABLE_SESSIONS', 'teamsessions', false);
}	
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>IHS Team Messages</title>
<?php 
require './php/db_utils.php';
require './php/db_access.php';

//TODO: use actual cookie, this is just for testing
$_COOKIE['ihsaccount'] = '2';
// END TODO

$_LOGGEDIN = !is_null($_COOKIE['ihsaccount']);
?>
</head>
<body>
<?php
if ($_LOGGEDIN) {
	$dbLink = _openDB();
	if ($dbLink) {
		// show message list
		// the cookie should have the user's account ID
		$response = _getMessageListForUser ($dbLink, $_COOKIE['ihsaccount'], false);
		echo '<pre>';
		echo Json_encode($response, JSON_PRETTY_PRINT);
		echo '</pre>';
	} else {
		// unable to open database
		echo '<p>Error opening message database. Check the server status and your Internet connection.</p>';
	}
} else {
	// show user/pass prompt
}
?>
</body>
</html>
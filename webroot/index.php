<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>IHS Team Messages</title>
<?php 
require './php/db_utils.php';
require './php/db_access.php';

$_LOGGEDIN = isset($_COOKIE['ihsaccount']);
?>
    <script src="./js/jquery.js"></script>
    <script src="./js/cookies.js"></script>
	<script type="text/javascript" language="javascript">
		$(document).ready (function() {
			$('#loginSubmit').click(signInBtnClick);	
		});	
	</script>
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
	echo "<div id=\"loginDiv\">
	<p><label id=\"loginUserLabel\">Username:</label><br/>
	<input id=\"loginUsername\" type=\"text\" /></p>
	<p><label id=\"loginPassLabel\">Password:</label><br/>
	<input id=\"loginPassword\" type=\"password\" /></p>
	<p><input id=\"loginSubmit\" type=\"submit\" value=\"Sign in\" /></p>
	</div>";
}
?>

<script type="text/javascript" language="javascript">
	function signInBtnClick () {
		var signInUrl = './php/signin.php';
		signInUrl = signInUrl+ '?username=' + $('#loginUsername').val();
		signInUrl = signInUrl+ '&password=' + $('#loginPassword').val();
		
		var getResponse = $.get(signInUrl);
		
		// if the response comes back let the user know.
		getResponse.done( function(response) {
			if (response.data != null) {
				// user is authorized so...
				// * save token in cookie
				createCookie ('ihsaccount', response.data.token, 0);
				// * reload the home page
				window.location.href = './index.php';
				// for now, we'll just show a message
				// alert ('worked!');
			}
			if (response.error) {
				// user is not athorized so...
				// * display error message
				// for now, we'll just show a message
				alert ('didn\'t work!');
			}
		});
	}		
</script>
</body>
</html>
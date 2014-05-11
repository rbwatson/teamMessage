<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Field Team Messages</title>
<?php 
require './php/db_utils.php';
require './php/db_access.php';

$_LOGGEDIN = isset($_COOKIE['teamaccount']);
?>
    <script src="./js/jquery.js"></script>
    <script src="./js/cookies.js"></script>
	<script type="text/javascript" language="javascript">
		$(document).ready (function() {
			$('#loginSubmit').click(signInBtnClick);
			$('#signOutBtn').click(signOutBtnClick);
		});	
	</script>
</head>
<body>
<?php
if ($_LOGGEDIN) {
	echo '<div id="messageListTop"><p class="messageListPageHead">Messages</p></div>';
	echo '<div id="signoutButtonDiv"><input type="button" id="signOutBtn" value="Sign out"></div>';
	echo '<div id="messageListDiv">';
	$dbLink = _openDB();
	if ($dbLink) {
		// show message list
		// the cookie should have the user's account ID
		$response = _getMessageListForUser ($dbLink, $_COOKIE['teamaccount'], false);
		if (isset($response['data'])) {
			$messages = $response['data'];
		} else {
			$messages = '';
		}
		if (0 == count($messages)) {
			// no messages
			echo '<p>You don\'t have any messages.</p>';
		} else {
			echo '<table id="messageListTable">';
			echo '<tr class="listHeaderRow"><th class="listFromHeader">From</th><th class="listDateHeader">Date</th><th class="listSubjHeader">Subject</th></tr>';
			foreach ($messages as $msg) {
				// format message
				echo '<tr class="listMessageRow">';
				echo '<td class="listFromEntry">'.$msg['fromName'].'</td>';
				echo '<td class="listDateEntry">'.$msg['sentDate'].'</td>';
				echo '<td class="listSubjEntry">'.$msg['subject'].'</td>';
				echo '</tr>';
			}
			echo '</table>';
		}
	} else {
		// unable to open database
		echo '<p>Error opening message database. Check the server status and your Internet connection.</p>';
	}
	echo '</div>';
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
	var token = <?php echo '"'.(isset($_COOKIE['teamaccount']) ? $_COOKIE['teamaccount'] : 0).'"'; ?>;
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
				createCookie ('teamaccount', response.data.token, 0);
				// * reload the home page
				window.location.href = './index.php';
				// for now, we'll just show a message
				// alert ('worked!');
			}
			if (response.error) {
				// user is not athorized so...
				// * display error message
				// for now, we'll just show a message
				alert ('Unable to sign in.\n\nCheck your username and password and try again.');
			}
		});
	}
	
	function signOutBtnClick () {		
		// close session
		var signOutUrl = './php/signout.php';
		signOutUrl = signOutUrl + '?token=' + token;
		
		var getResponse = $.get(signOutUrl);
		
		getResponse.done( function(response) {
			if (response.data != null) {
				// user is authorized so...
				// * save token in cookie
				eraseCookie ('teamaccount');
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
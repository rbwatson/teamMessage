<?php
/* 
 * database access methods 
*/
function _openSessionAndReturnToken ($user, $pass) {
	// reutrn a dummy for now
	// TODO: actually create a new session in the database
	return time();
}


function _getUserIdFromToken($userToken) {
	// TODO: look up token and return user ID to use in SQL queries
	// for now, return the default user
	return 2;
}

function _getMessageListForUser ($dbLink, $userToken, $unreadOnly) {
	if (empty($unreadOnly)) {
		$unreadOnly = 0;
	}
	
	$userId = _getUserIdFromToken($userToken);
	
	$queryString = 'CALL GetMessagesToUser('.$userId.','.$unreadOnly.')';
	$result = @mysqli_query ($dbLink, $queryString);
	if (!$result) {
		$localErr = '';
		$localErr['code'] = 500;
		$localErr['info'] = 'Database error';
		$localErr['query'] = $queryString;
		$localErr['sqlerr'] = @mysqli_error($dbLink);
		$response['error'] = $localErr;
	} else {
		$idx = 0;
		if (mysqli_num_rows($result)  > 0) {
			while ($thisRecord = mysqli_fetch_assoc($result))  {
				$response['data'][$idx] = array_merge($thisRecord);
				foreach ($response['data'][$idx] as $k => $v) {
					// set "null" strings to null values
					if ($v == 'NULL') {
						$response['data'][$k] = NULL;
					}
				}
				$idx += 1;
			}
		}
		if ($idx == 0) {
			$localErr = '';
			$localErr['code'] = 404;
			$localErr['info'] = 'No messages found for the specified study and study period';
			$response['error'] = $localErr;
		}
	}
	return $response;
}


?>
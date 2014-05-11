<?php
require 'db_access.php';
/*
	requires username and password query parameters
*/
	$username = null;
	$password = null;
	$param = 'username';
	if (!empty($_GET[$param])){
		$username = $_GET[$param];
    } else {
		$error[$param] = 'missing';
	}
	
	$param = 'password';
	if (!empty($_GET[$param])){
		$password = $_GET[$param];
    } else {
		$error[$param] = 'missing';
	}
	
	if (!empty($username) && !empty($password)) {	
/*
		$data['username'] = $username;
		$data['password'] = $_GET['password'];
*/
		$data['token'] = _openSessionAndReturnToken ($username, $password);
		
		$response['data'] = $data;
	} else {
		$response['error'] = $error;
	}
	
	$response['debug']['module'] = __FILE__;
	
	require 'format_response.php';
	print $fnResponse;
?>

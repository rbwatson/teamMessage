<?php
	$data['username'] = $_GET['username'];
	$data['password'] = $_GET['password'];
	$data['token'] = time();
	
	$response['data'] = $data;
	$response['debug']['module'] = __FILE__;
	
	require 'format_response.php';
	print $fnResponse;
?>

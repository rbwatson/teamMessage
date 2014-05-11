<?php
	$data['token'] = 0;
	
	$response['data'] = $data;
	$response['debug']['module'] = __FILE__;
	
	require 'format_response.php';
	print $fnResponse;
?>

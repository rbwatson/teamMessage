<?php 
// assumes $response has a response buffer and
// puts the formatted response buffer in $fnResponse

if (!headers_sent()) {
	header('content-type: application/json');
	header('X-PHP-Response-Code: 200', true, 200);
}

$thisParam = "callback";
if (array_key_exists($thisParam, $_GET)) {
	if (!empty($_GET[$thisParam])) {
		$jsonpTag = $_GET[$thisParam]; // set by jquery ajax call when using jsonp data type
	}
}

if (!empty($jsonpTag)) { 
	// format and send output
	// no error information is returned in the JSONP response!
	$fnResponse = $jsonpTag . '(' . json_encode($response['data']) . ')';
} else {
	// no callback param name so return an error
	// this line only works on PHP > 5.4.0, which not everyone seems to have.
	//   http_response_code(500);
	// this works on PHP > 4.3 (or so)
	$fnResponse = json_encode($response);
}
?>
<?php
require 'config_files.php';

function _openDB() {
	$link = @mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_DATABASE_NAME);
	return $link;
}

function _format_object_for_SQL_insert ($tableName, $object) {
	// set the dateCreated field
	$now = new DateTime();
	$object['dateCreated'] = $now->format('Y-m-d H:i:s');
			
	// format the fields of the object to the appropriate SQL syntax		
	foreach ($object as $dbCol => $dbVal) {
		isset($dbColList) ? $dbColList .= ', ' : $dbColList = '';
		isset($dbValList) ? $dbValList .= ', ' : $dbValList = '';										
		$dbColList .= $dbCol;
		if (empty($dbVal) && (strlen($dbVal)==0)) {
			$dbValList .= 'NULL';
		} else {
			$escapedString = str_replace("'","''",$dbVal);
			$dbValList .= '\''.$escapedString.'\'';
		}							
	}
	$queryString = 'INSERT INTO '.$tableName.' ('.$dbColList.') VALUES ('.$dbValList.')';
	return $queryString;
}

function get_study_owner ($studyId) {
	// TODO: check the study DB.
	// return the defaultReseacher ID for now until the study interface is ready
	if ($studyId == 1234) {
		return 2;
	} else {
		return -1;
	}
}
?>
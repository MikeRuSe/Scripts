<?php
session_start(); 
/*
PHP code for scanning files for viruses using virustotal.com API
File coded by Adrian at www.TheWebHelp.com 
*/

header("Content-Type: text/plain"); 

// edit the virustotal.com api key, get one from the site
$virustotal_api_key = "45eb3db57881fe217aad8935f2f7ce0e025098f02545649390c4ff6ab491a977";

// enter here the path of the file to be scanned
$var_value = $_GET['varname'];
$file_to_scan = $var_value;

// get the file size in mb, we will use it to know at what url to send for scanning (it's a different URL for over 30MB)
$file_size_mb = filesize($file_to_scan)/1024/1024;

// calculate a hash of this file, we will use it as an unique ID when quering about this file
$file_hash = hash('sha256', file_get_contents($file_to_scan));


// [PART 1] hecking if a report for this file already exists (check by providing the file hash (md5/sha1/sha256) 
// or by providing a scan_id that you receive when posting a new file for scanning
// !!! NOTE that scan_id is the only one that indicates file is queued/pending, the others will only report once scan is completed !!!
$report_url = 'https://www.virustotal.com/vtapi/v2/file/report?apikey='.$virustotal_api_key."&resource=".$file_hash;

$api_reply = file_get_contents($report_url);

// convert the json reply to an array of variables
$api_reply_array = json_decode($api_reply, true);


// your resource is queued for analysis
if($api_reply_array['response_code']==-2){
	echo $api_reply_array['verbose_msg'];
}

// reply is OK (it contains an antivirus report)
// use the variables from $api_reply_array to process the antivirus data
if($api_reply_array['response_code']==1){
	echo "\nWe got an antivirus report, there were ".$api_reply_array['positives']." positives found. Here is the full data: \n\n";
	print_r($api_reply_array);
	exit;
}


// [PART 2] a report for this file was not found, upload file for scanning
if($api_reply_array['response_code']=='0'){

	// default url where to post files
	$post_url = 'https://www.virustotal.com/vtapi/v2/file/scan';

	// get a special URL for uploading files larger than 32MB (up to 200MB)
	if($file_size_mb >= 32){
		$api_reply = @file_get_contents('https://www.virustotal.com/vtapi/v2/file/scan/upload_url?apikey='.$virustotal_api_key);
		$api_reply_array = json_decode($api_reply, true);
		if(isset($api_reply_array['upload_url']) and $api_reply_array['upload_url']!=''){
			$post_url = $api_reply_array['upload_url'];
		}
	}
	
	// send a file for checking

	// curl will accept an array here too:
	$post['apikey'] = $virustotal_api_key;
	$post['file'] = '@'.$file_to_scan;
	
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL,$post_url);
	curl_setopt($ch, CURLOPT_POST,1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	$api_reply = curl_exec ($ch);
	curl_close ($ch);
	
	$api_reply_array = json_decode($api_reply, true);
	
	if($api_reply_array['response_code']==1){
		echo "\nfile queued OK, you can use this scan_id to check the scan progress:\n".$api_reply_array['scan_id'];
		echo "\nor just keep checking using the file hash, but it will only report once it is completed (no 'PENDING/QUEUED' reply will be given).";
	}

}
$API= $api_reply_array['scan_id'];
		$var = "ini/datos.ini";
		$base = parse_ini_file($var);		
		$php = new PDO($base["baseDeDatos"],$base["usuario"],$base["password"]);
	
			$con = $php->prepare("INSERT INTO files VALUES (DEFAULT, :file, :api_id);");
			$con->bindParam(':file',$file_to_scan);
			$con->bindParam(':api_id',$API);
			$con->execute();
session_destroy();
header("Location: subir.php");
?>
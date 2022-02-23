<?php
    //ADAPTED MAINLY FROM https://www.geeksforgeeks.org/how-to-parse-a-json-file-in-php/

    // Get software name.
    $sw_name=strtolower($argv[1]); 
 
    // Source config. Specific overrides common when two vars collide.
    $common_conf   = 'conf/common.conf.php';
    $specific_conf = "conf/${sw_name}.conf.php";
    require_once("$common_conf");
    if (file_exists($specific_conf)) {
        require_once("$specific_conf");
    }
  
    // Read the JSON file 
    $json = file_get_contents("https://endoflife.date/api/${sw_name}.json");
  
    // Decode the JSON file
    $json_data = json_decode($json,true);
  
    // Display data
    echo "Software Name: " . $sw_name . "\n";
    foreach($json_data as $item) {
       $date_today    = date("Y-m-d");
       $search_key_ok = array_key_exists($search_key, $item);
       $not_yet_eol   = ($item[$search_key] > $date_today) or
                        (isset($item[$search_key]));
                        //($item[$search_key] == "" );
/*
       echo 'debug start' . "\n";
       echo "search_key_ok: " . $search_key_ok . "\n";
       echo "not_yet_eol: "   . $not_yet_eol   . "\n";
       echo '//debug' . "\n";
*/
       if ( $search_key_ok and $not_yet_eol ) {

           $version_key_ok=array_key_exists($version_key, $item);
           $latest_version_key_ok=array_key_exists($latest_version_key, $item);
           if ($version_key_ok) {
               echo "Supported Stable Release Line: " . $item[$version_key] . "\n";
           }
           if ($latest_version_key_ok) {   
               echo "Latest Version: " . $item[$latest_version_key] . "\n";
               echo "\n\n";
           }
       }
    } //END: foreach

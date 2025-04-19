<?php

// Sample 1. Get information about server
$request = "https://api.64clouds.com/v1/getServiceInfo?veid=1932044&api_key=YOUR_API_KEY_HERE";
$serviceInfo = json_decode (file_get_contents ($request));
print_r ($serviceInfo);

?>

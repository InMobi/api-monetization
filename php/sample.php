
<?php
/////////////////////////////////////////////////////////////////
// Copyright © 2015 InMobi Technologies Pte. Ltd. All rights reserved.

//                           MIT License

//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.

//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////// 

error_reporting(E_ERROR | E_PARSE);
ini_set('memory_limit', '-1');

require_once(dirname(__FILE__)."/inmobi/monetization/ads/Banner.php");
require_once(dirname(__FILE__)."/inmobi/monetization/ads/Interstitial.php");
require_once(dirname(__FILE__)."/inmobi/monetization/ads/Native.php");

$banner = new Banner();
$property = new Property("YOUR_PROPERTY_ID");

$impression = new Impression(new Slot(15,"top"));

$device = new Device("USER_CARRIER_IP","USER_WEBVIEW_USER_AGENT");

//var_dump($request->impression);
//if($request->isValid() == true) echo "Request is valid"; else echo "Request is not valid";
$request = new Request();
$request->property = $property;
$request->impression = $impression;
$request->device =$device;
$request->requestType = AdRequest::BANNER;
$ads = $banner->loadRequest($request);
//if($request->isValid() == true) echo "Request is valid"; else echo "Request is not valid";
//echo function_exists('curl_version');
// var_dump($banner->loadRequest($request));
 //var_dump($banner->errorCode);
// echo "</br>";
// var_dump($banner->loadRequest($request));
// echo "</br>";
// var_dump($banner->loadRequest($request));

$int = new Interstitial();
$request->impression->slot->adSize = 14;
//$ads = $int->loadRequest($request);
echo "size of ads:".sizeof($ads);
$native = new Native();
//$ads = $native->loadRequest($request);
//echo "size of ads:".sizeof($ads);
//var_dump($ads);
//var_dump($native->loadRequest($request));
foreach($ads as $nativeResponse) {
	//var_dump($nativeResponse);
	echo "</br></br>";
	//echo $nativeResponse->convertPubContentToJsonObject();
}

?>
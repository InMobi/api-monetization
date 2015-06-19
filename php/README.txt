InMobiAPIMonetizationLibrary-PHP
================================

This is the API library, build for Server integrations which use PHP technology

Note: This library code has been tested with PHP v 5.0 or later.

API usage examples:

Dependencies:

require_once(dirname(__FILE__)."/inmobi/monetization/ads/Banner.php");
require_once(dirname(__FILE__)."/inmobi/monetization/ads/Interstitial.php");
require_once(dirname(__FILE__)."/inmobi/monetization/ads/Native.php");

//Create a property Object
$property = new Property("YOUR_PROPERTY_ID");

//Create an impression object
//default slot size is 15, i.e. 320x50 banner unit
$impression = new Impression(new Slot(15,"top"));

//Create a device object
$device = new Device("YOUR_CARRIER_IP","YOUR_USER_AGENT");

//Create a request object
$request = new Request();
$request->property = $property;
$request->impression = $impression;
$request->device =$device;

//Create a Banner object
$banner = new Banner();

$ads = $banner->loadRequest($request);
foreach($ads as $bannerResponse) {
	var_dump($bannerResponse);
}

//Create a new Interstitial object
$interstitial = new Interstitial();

//default interstitial slot size is 14, i.e. 320x480 unit
$request->impression->slot->adSize = 14;

$ads = $int->loadRequest($request);
foreach($ads as $bannerResponse) {
	var_dump($bannerResponse);
}

//Create a native object
$native = new Native();

$ads = $native->loadRequest($request);

foreach($ads as $nativeResponse) {
	var_dump($nativeResponse);
	echo "</br></br>";
	//this will be your JSON template, as created in InMobi UI.
	echo $nativeResponse->convertPubContentToJsonObject();
}
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
require_once(dirname(__FILE__)."/Enums.php");
require_once(dirname(__FILE__)."/Request.php");
/**
* This class is used by Banner, Interstitial or Native moentization classes to generate
* a JSON payload used for making the POST body for InMobi ad request.
*/
class JSONPayloadCreator {

	/**
	 * This method constructs a json object, depending on the request parameters
	 * passed.
	 * 
	 * @note The request object needs to have valid arguments, depending on the
	 *       AdRequestType Please check if the request.isValid() returns
	 *       true, as this method internally validates the request & proceeds if
	 *       & only the request object is valid for the AdRequestType.
	 * @param $request
	 *            The request object, for which a JSON would be constructed
	 * @return Json Object which is used as POST Body in the InMobi API 2.0 Ad
	 *         Request. TODO User demography as part of JSON API request.
	 */
	public static function generateInMobiAdRequestPayload($request) {
		if($request == null || gettype($request) != "object") return null;
		if($request->isValid() != true) return null;

		$mainObjectArray = array();

		if($request->requestType == AdRequest::NATIVE) {
			$mainObjectArray['responseformat'] = "native";
		} else {
			$mainObjectArray['responseformat'] = "axml";
		}
		
		$propertyJson = JSONPayloadCreator::getPropertyJson($request->property);
		if($propertyJson != null) {
			$mainObjectArray['site'] = $propertyJson;
		}

		$impJson = JSONPayloadCreator::getImpressionJson($request->impression,$request->requestType);
		if($impJson != null) {
			$mainObjectArray['imp'][] = $impJson;
		}
		$deviceJson = JSONPayloadCreator::getDeviceJson($request->device);
		if($deviceJson != null) {
			$mainObjectArray['device'] = $deviceJson;
		}

		$userJson = JSONPayloadCreator::getUserJson($request->user);
		if($userJson != null && empty($userJson) == false) {
			$mainObjectArray['user'] = $userJson;
		}

		return json_encode($mainObjectArray);
	}

	private static function getPropertyJson($property) {
		$propArray = array();
		$propArray['id'] = $property->propertyId;
		return $propArray;
	}

	private static function getImpressionJson($impression,$requestType) {

		$impArray = array();
		$impArray['ads'] = $impression->noOfAds;
		$impArray['displaymanager'] = $impression->displayManager;
		$impArray['displaymanagerver'] = $impression->displayManagerVersion;
		if($requestType == AdRequest::INTERSTITIAL) {
			$impArray['adtype'] = "int";
		}

		if($requestType != AdRequest::NATIVE) {
			$bannerArray = array();
			$slot = $impression->slot;
			$bannerArray['adsize'] = $slot->adSize;
			if(StubValidator::isStringValid($slot->position)) {
				$bannerArray['pos'] = $slot->position;
			}
			$impArray['banner'] = $bannerArray;
		}

		return $impArray;
	}
	private static function getDeviceJson($device) {
		$deviceArray = array();
		$deviceArray['ip'] = $device->carrierIP;
		$deviceArray['ua'] = $device->userAgent;

		//anddroid identifiers
		$gpid = $device->gpId;
		if(StubValidator::isStringValid($gpid)) {
			$deviceArray['gpid'] = $gpid;
		}
		//aid here must be a SHA-1 hashed value of the original ANDROID_ID, or otherwise should be 
		//passed as md5 value..
		// if you don't know this, do not pass this identifier, but rather pass google advertising identifier.
		$aid = $device->androidId;
		if(StubValidator::isStringValid($aid)) {
			$deviceArray['o1'] = $aid;
		}

		//iOS identifiers
		$ida = $device->idfa;
		if(StubValidator::isStringValid($ida)) {
			$deviceArray['ida'] = $ida;
		}
		$adt = $device->adTrackingDisabled;
		if($adt == true) {
			$deviceArray['adt'] = 1;
		} else {
			$deviceArray['adt'] = 0;
		}
		//geo object
		$geo = $device->geo;
		if($geo != null && $geo->isValid() == true) {
			$geoArray = array();
			$geoArray['lat'] = $geo->lat;
			$geoArray['lon'] = $geo->lon;
			$geoArray['accu'] = $geo->accuracy;
			$deviceArray['geo'] = $geoArray;
		}

		return $deviceArray;
	}

	private static function getUserJson($user) {
		//TODO Data object implementation
		$userArray = array();
		if($user == null || gettype($user) != "object") return $userArray;
		
		$yob = $user->yearOfBirth;
		if(StubValidator::isIntegerValid($yob) && $yob > 0) {
			$userArray['yob'] = $yob;
		}
		$gender = $user->gender;
		if($gender != null) {
			if($gender == Gender::MALE) {
				$userArray['gender'] = 'M';
			} else if($gender == Gender::FEMALE) {
				$userArray['gender'] = 'F';
			}
		}
		return $userArray;
	}

}

?>

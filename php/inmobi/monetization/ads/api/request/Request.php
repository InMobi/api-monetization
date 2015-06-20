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
require_once(dirname(__FILE__)."/Stubs.php");
require_once(dirname(__FILE__)."/JSONPayloadCreator.php");

/**
 * The top-level ad request is required to contain at least the site containing
 * the unique site ID, and the device containing the client IP address and user
 * agent information. </br>
 * 
 * <p>
 * <b>Note:</b>
 * </p>
 * Please provide a valid Request object to use one of the AdFormats under
 * com.inmobi.monetization.ads package. To check if the Request object is valid,
 * please make use of the isValid() method.
 * 
 * @author rishabhchowdhary
 * 
 */

class Request {

var $impression;
var $user;
var $property;
var $device;
/**
* The requestType is one of BANNER/INTERSTITIAL/NATIVE object, and is internally set from Banner, Interstitial, 
* or Native classes.
**/
var $requestType;


function __construct() {
	$impression = null;
	$user = null;
	$property = null;
	$device = null;
	$requestType = AdRequest::NONE;
}

/**
* This is a static function to create a Request object with the required parameters
* @param $i The impression object, is mandatory.
* @param $u The user object, is an optional.
* @param $p The 
*/
public static function withRequestStubs($i, $u, $p,$d) {
	$r = new Request();
	$r->impression = $i;
	$r->user = $u;
	$r->property = $p;
	$r->device = $d;
	return $r;
}

/**
 * This method basically checks for mandatory parameters, which should not
 * be null, and are required in a request:<br/>
 * <b>InMobi Property ID:</b> should be valid String, as obtained from
 * InMobi, present in Property <br/>
 * <b>Carrier IP:</b> should be valid Mobile Country Code, present in device <br/>
 * <b>User Agent:</b> should be valid Mobile UA string, present in device <br/>
 * <b>gpID/AndroidId/IDA:</b> A valid device ID is <i>strongly
 * recommended.</i> The value can be ignored for Mobile Web platform.
 * 
 * @param type
 *            The AdRequest Type, one of Native,Banner or Interstitial
 * @note Passing in garbage values for any of mandatory parameters would
 *       terminate the request from server side. UA is actually
 * @return
 */
public function isValid() {
	$isValid = false;
	
	if ($this->property != null && $this->property->isValid() == true) {
		if ($this->device != null && $this->device->isValid()) {

			if ($this->requestType == AdRequest::NATIVE) {
				// impression is not mandatory for native ads.
				if ($this->user != null) {
					$isValid = $this->user->isValid();
				} else {
					$isValid = true;
				}
			} else if ($this->requestType == AdRequest::BANNER
					|| $this->requestType == AdRequest::INTERSTITIAL) {
				if ($this->impression != null && $this->impression->isValid()) {

					if ($this->user != null) {
						$isValid = $this->user.isValid();
					} else {
						$isValid = true;
					}
				} else {
					echo "Please provide a valid Impression in the request";
				}
			} else {
				echo "Valid AdRequest enum not found.";
			}
		} else {
			echo "Please provide a valid Device in the request";
		}
	} else {
		echo "Please provide a valid Property in the request";
	}

	return $isValid;
}

public function toJSON() {
	return JSONPayloadCreator::generateInMobiAdRequestPayload($this);
}

}

?>

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
require_once(dirname(__FILE__)."/ErrorCode.php");
/**
 * This class can be used to request InMobi Ads, by passing in a valid
 * Request object, and a ad format type. Please use this class to obtain the
 * response as a String. Please check the
 * <i>errorCode</i> value if in case an error has occurred, if the
 * response returned is invalid. This class makes use of the
 * java.net.HttpURLConnection, to request InMobi ads in a synchronous fashion.
 * Publishers may create new Threads themselves to fire http requests in an
 * asynchronous manner.
 * 
 * @note It is the publisher's responsibility to check if the request contains the
 *       mandatory required parameters. If the mandatory parameters are not
 *       present, our servers would terminate the request. <br/>
 *       We recommend converting Request to JsonObject using <b>
 *       JSONPayloadCreator</b>, so that any missing parameter can be
 *       identified.<br/>
 *       Publishers may also check 'isRequestInProgress' before calling any of
 *       request methods, to check if a request was in progress or not.
 * @author rishabhchowdhary
 * 
 */
class RequestResponseManager {

	function _isCurl(){
	    return function_exists('curl_version');
	}
	public $errorCode;
	/**
	* This function returns a String response for the Request passed. 
	* @note Please make sure the request object is valid.
	* @param $request The Request object.
	* @return String response, as obtained by the server.
	*/
	public function fetchResponse($requestJson,$userAgent,$carrierIP) {
		if(_isCurl() == false) {
			echo "Curl is not supported.";
			return null;
		}

		if($requestJson != null && empty($requestJson) != true) {
			//fire the http request
			$ch = curl_init();

			//set the url, number of POST vars, POST data
			curl_setopt($ch,CURLOPT_URL,"http://api.w.inmobi.com/showad/v2.1");
			//curl_setopt($ch,CURLOPT_POST, 1);
			curl_setopt($ch,CURLOPT_POSTFIELDS, $requestJson);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                                            'Content-Type: application/json'
                                            ,'x-device-user-agent:'.$userAgent
                                            ,'x-forwarded-for:'.$carrierIP
                                            ));
			//execute post
			$result = curl_exec($ch);
			//close connection
			$httpStatusCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

			curl_close($ch);
			if($httpStatusCode != 200) {
				if($httpStatusCode == 400) {
					$this->errorCode = new ErrorCode(ErrorCode::INVALID_REQUEST,ErrorCode::INVALID_REQUEST_MSG);
				} else if($httpStatusCode == 204) {
					$this->errorCode = new ErrorCode(ErrorCode::NO_FILL,ErrorCode::NO_FILLMSG);
				} else if($httpStatusCode == 504) {
					$this->errorCode = new ErrorCode(ErrorCode::GATEWAY_TIME_OUT,ErrorCode::GATEWAY_TIMEOUT_MSG);
				}
			}

			return $result;
		}
	}
}

?>

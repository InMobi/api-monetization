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
require_once(dirname(__FILE__)."/NativeResponse.php");

/**
 * This class can be used to obtain an Array of NativeResponse objects, from
 * the raw response(as String), obtained from the InMobi API 2.0 Server
 * response.
 * 
 * @author rishabhchowdhary
 * 
 */
class NativeResponseParser {

	/**
	 * This function converts the String response to NativeResponse
	 * objects.</br>
	 * 
	 * <p>
	 * <b>Note:</b>
	 * </p>
	 * If the server returned a no-fill, or there was a parsing error, this
	 * function would return an empty array.
	 * 
	 * @param $response
	 *            The String response as obtained from InMobi ad server.
	 * @return Array of NativeResponse objects.
	 */
	public function parseResponse($response) {
		//JSON
		
		$adsArray = array();
		if($response != null) {
			$jsonResponse = json_decode($response);
			$i = 0;
			foreach ($jsonResponse->ads as $jsonAd) {
				
				$ad = new NativeResponse();
				$ad->pubContent = $jsonAd->pubContent;
				$ad->ns = $jsonAd->namespace;
				$ad->contextCode = $jsonAd->contextCode;
				if($ad->isValid()) {
					$adsArray[$i] = $ad;
					$i++;
				}
			}
		}
		return $adsArray;
	}
}

?>
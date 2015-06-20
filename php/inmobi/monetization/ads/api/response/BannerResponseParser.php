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
require_once(dirname(__FILE__)."/BannerResponse.php");
/**
 * This class can be used to obtain an Array of BannerResponse objects, from
 * the InputStream, as obtained from the API 2.0 server response.
 * 
 * @author rishabhchowdhary
 * 
 */
class BannerResponseParser {

	/**
	 * This function converts the input response to BannerResponse
	 * objects.</br>
	 * <p>
	 * <b>Note:</b>If the server returned a no-fill, or there was a parsing
	 * error, this function would return an empty arraylist.
	 * </p>
	 * 
	 * @param $response
	 *            The String response, as obtained from the ad-server.
	 * @return Array of BannerResponse objects
	 */
	public function parseResponse($response,$adType) {

		$vals =simplexml_load_string($response);
		$p = xml_parser_create();
		xml_parse_into_struct($p, $response, $vals, $index);
		xml_parser_free($p);

		$ads = array();
		$ad = null;
		foreach ($vals as $key=>$value ) {
			//each $value is an array
			$i = 0;
			
			if( $value['tag'] == 'AD' ) {

				if($value['type'] == 'open') {

					$ad = new BannerResponse();
					$attrs = $value['attributes'];
					$ad->adUrl = "";//TODO
					$ad->actionType = $attrs['ACTIONTYPE'];
					$ad->actionName = $attrs['ACTIONNAME'];
					$ad->adSize = new AdSize($attrs['WIDTH'],$attrs['HEIGHT']);
					$rm = $attrs['TYPE'];
					$ad->CDATA = $value['value'];
					 
				}

				else if($value['type'] == 'cdata') {
					$ad->CDATA = $value['value'];
				}

				else if($value['type'] == 'close') {

					if($ad->isValid() == true) {
						$ads[$i] = $ad;
						$i++;
					}
				} 
			} else if($value['tag'] == 'ADURL') {
					$ad->adUrl = $value['value'];
				}
		}

		return $ads;
	}
}

?>
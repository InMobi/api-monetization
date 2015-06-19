<?php

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
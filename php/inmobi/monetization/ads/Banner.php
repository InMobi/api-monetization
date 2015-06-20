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
require_once(dirname(__FILE__)."/AdFormat.php");
require_once(dirname(__FILE__)."/api/response/BannerResponseParser.php");

/**
 * Publishers can use this class instance to request banner ads from InMobi.
 * 
 * @note Please pass the mandatory request params.
 * @author rishabhchowdhary
 * 
 */
class Banner  extends AdFormat {

	protected $xmlResponseParser;

	function __construct() {
		parent::__construct();
		$this->requestType = AdRequest::BANNER;
		$this->xmlResponseParser = new BannerResponseParser();
     } 
     /**
	 * This method is internally called from loadRequest.
	 * 
	 * @param request
	 *            The Request object
	 * @return Array of BannerResponse objects.
	 */
     protected function loadRequestInternal($request) {
     	$response = parent::loadRequestInternal($request);
     	$adsArray = array();
     	if($response != null && $this->errorCode == null) { //valid response received without any error
     		$adsArray = $this->xmlResponseParser->parseResponse($response,$this->requestType);
     		parent::checkAndSetError($adsArray);
     	}

     	return $adsArray;
     }

     /**
	 * This function loads banner ads synchronously.
	 * 
	 * @param $request
	 *            The Request object, containing the required request params.
	 * @NotNull request
	 *       The function returns null if the request was already in progress.
	 *       Please also provide a valid Request. Please check if the
	 *       Request object is valid through the isValid() method.
	 * @return Array containing the BannerResponse objects.
	 */
     public function loadRequest($request) {
		
		if(parent::canLoadRequest($request,$this->requestType) == true) {
			return $this->loadRequestInternal($request);
		}
		return null;
     }
}

?>

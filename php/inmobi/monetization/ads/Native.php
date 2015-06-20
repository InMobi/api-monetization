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
require_once(dirname(__FILE__)."/api/response/NativeResponseParser.php");

/**
 * Publishers may use this class to request Native ads from InMobi.
 * 
 * @author rishabhchowdhary
 * 
 */
class Native extends AdFormat {

	protected $jsonParser;

	function __construct() {
		parent::__construct();
		$this->jsonParser = new NativeResponseParser();
		$this->requestType = AdRequest::NATIVE;
     }

     protected function loadRequestInternal($request) {
     	
     	$response = parent::loadRequestInternal($request);
     	$adsArray = array();
     	if($response != null && $this->errorCode == null) { //valid response received without any error
     		$adsArray = $this->jsonParser->parseResponse($response);
     		parent::checkAndSetError($adsArray);
     	}
     	
     	return $adsArray;
     }

     /**
	 * This function loads native ads synchronously.
	 * 
	 *       The function returns null if the request was already in progress.
	 *       Please also provide a valid Request. You may check if the
	 *       Request object is valid by cheking isValid() method.
	 * @return ArrayList containing the NativeResponse objects.
	 */
     public function loadRequest($request) {
		
		if(parent::canLoadRequest($request,$this->requestType) == true) {
			return $this->loadRequestInternal($request);
		}
		return null;
     }

}

?>
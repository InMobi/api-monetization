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
require_once(dirname(__FILE__)."/api/net/ErrorCode.php");
require_once(dirname(__FILE__)."/api/net/RequestResponseManager.php");
require_once(dirname(__FILE__)."/api/request/Request.php");

/**
 * This is the abstract base class for InMobi ad formats. The class must be
 * extended( please look at Banner,Interstitial classes for perusal.
 * 
 * @author rishabhchowdhary
 * 
 */
abstract class AdFormat  {
    protected $isRequestInProgress = false;
   	public $errorCode = null;
	protected $manager ;
	protected $requestType;

    function __construct() {
      
      $this->requestType = AdRequest::NONE;
      $this->manager = new RequestResponseManager();
    } 
    
    public function canLoadRequest($request,$requestType) {
    	
		if ($request == null) {
			return false;
		}
        $request->requestType = $requestType;
        if($request->isValid() == true) {
            if($this->isRequestInProgress == false) {
                $this->isRequestInProgress = true;
                return true;
            } else {
                return false;
            }
        } 
        return false;

	}
    public abstract function loadRequest($request);


    protected  function loadRequestInternal($request) {
        $errorCode = null;

        $response = $this->manager->fetchResponse($request->toJSON(),
            $request->device->userAgent,
            $request->device->carrierIP);
        $this->isRequestInProgress = false;
        $this->errorCode = $this->manager->errorCode;
        return $response;
    }

    protected function checkAndSetError($adsArray) {
        if(gettype($adsArray) != "array") {// response object will always be an array
                $this->errorCode = new ErrorCode(ErrorCode::INTERNAL_ERROR,ErrorCode::INTERNAL_ERROR_MSG;
            } else if(sizeof($adsArray) == 0) {
                $this->errorCode = new ErrorCode(ErrorCode::NO_FILL,ErrorCode::NO_FILLMSG);
            }
    }
}

?>

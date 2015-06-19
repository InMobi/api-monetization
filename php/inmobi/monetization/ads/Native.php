<?php

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
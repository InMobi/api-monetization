<?php
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
                $this->errorCode = new ErrorCode(ErrorCode::INTERNAL_ERROR,INTERNAL_ERROR_MSG.gettype($adsArray));
            } else if(sizeof($adsArray) == 0) {
                $this->errorCode = new ErrorCode(ErrorCode::NO_FILL,ErrorCode::NO_FILLMSG);
            }
    }
}

?>
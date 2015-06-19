<?php
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

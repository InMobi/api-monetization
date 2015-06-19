<?php
require_once(dirname(__FILE__)."/AdResponse.php");
/**
	 * This class represents the width/height parameter of served banner ad.
	 * 
	 * @author rishabhchowdhary
	 * 
	 */
	
	class AdSize {
		public $width = 0;
		public $height = 0;

		function __construct($w, $h) {
			
			if(!empty($w)) {
				if(gettype($w) == "string") {
					$this->width = intval($w);
				} else if(gettype($w == "integer")) {
					$this->width = $w;
				}
			}
			if(!empty($h)) {
				if(gettype($h) == "string") {
					$this->height = intval($h);
				} else if(gettype($h == "integer")) {
					$this->height = $h;
				}
			}
		}
		public function isValid() {
			$isValid = true;
			if( (ResponseValidator::isIntegerValid($this->width) == false)
			|| (ResponseValidator::isIntegerValid($this->height) == false) ) {
				$isValid = false;
			}
			
			else if($this->width <= 0 || $this->height <= 0) {
				$isValid = false;
			}
			return $isValid;
		}
	}

 class BannerResponse extends AdResponse  {

	/**
	 * The CDATA String, as obtained from the banner ad response from InMobi.
	 * 
	 * @warning <b>Please do not tamper with this String, and load it as it is
	 *          on the client side. Tampering with the String to scrape out any
	 *          specific html/javascript components may result in incorrect
	 *          results on InMobi portal, or may also lead to your site being
	 *          marked as invalid.</b>
	 */
	public $CDATA = null;
	/**
	 * The Click URL, as obtained from the banner ad response from InMobi.
	 * 
	 * @note The click URL is an optional value, and may be null in case of
	 *       specific ad response. Publishers are expected to refer to the click
	 *       URL only if its available, and open in the <b>device browser for
	 *       which the requests was fired.</b> <br/>
	 *       <i>Firing the click URL from your server may result in click
	 *       being not counted correctly.</i>
	 */
	public $adUrl = null;
	/**
	 * The general value of the action, associated with this ad unit.
	 * 
	 * @eg appStore, call, sms, calender, etc..
	 */
	public $actionName = null;
	/**
	 * The actionType is an integer value which defines the action, associated
	 * with this banner response. The associated action here implies the
	 * methodology to be followed, to open the post click action.</br>
	 * <b>General values:</b></br> <b>1</b>: Implies the click URL can be opened
	 * as a "full screen embedded browser" within the app.</br> For any other
	 * integer value, you may open the associated action as a general Intent,
	 * and let the device OS open the associated app( iTunes, GP, Default
	 * browser, etc.)</br>
	 * 
	 */
	public $actionType;
	/**
	 * The ad dimensions associated with this ad unit. Use adsize.width,
	 * adsize.height to obtain the specific width/height parameters.
	 */
	public $adSize = null;
	

	/**
	 * Use this method to check if this object has all the required parameters
	 * present. If this method returns false, the object generated after XML
	 * parsing would be discarded.
	 * 
	 * @return True, If the mandatory params are present.False, otherwise.
	 */
	public function isValid() {
		$isValid = true;
		if(ResponseValidator::isStringValid($this->CDATA) == false) {
			$isValid = false;
		}
		else if($this->adSize == null) {
			$isValid = false;
		}
		else if($this->adSize->isValid() == false) {
			$isValid = false;
		}
		return $isValid;
	}

}

?>

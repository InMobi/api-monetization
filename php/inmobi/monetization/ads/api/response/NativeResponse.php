<?php

require_once(dirname(__FILE__)."/AdResponse.php"); // For the AdResponse class, which is being extended by the NativeResponse class

/**
 * This class is used to construct Native response as a plain Java object.
 * 
 * @author rishabhchowdhary
 * 
 */
 class NativeResponse extends AdResponse {

	/**
	 * The 'namespace' parameter associated with this native ad unit. Use this
	 * String value in the client side code to trigger javascript function
	 * callbacks in the WebView.
	 */
	public $ns;
	/**
	 * The html/javascript code, which is to be executed in a hidden WebView on
	 * the client side. Please note that this code doesn't perform any rendering
	 * of the Native ad itself(<i>that responsibility is yours</i>) but this
	 * code must be used to track impression/clicks from the html/js. <br/>
	 * <b>Refer:</b> <br/>
	 * iOS: https://github.com/InMobi/iOS-Native-Samplecode-InMobi/ <br/>
	 * Android: https://github.com/InMobi/android-Native-Samplecode-InMobi/ <br/>
	 * examples to understand triggering of InMobi impression/clicks.
	 * 
	 * @warning <b>Please do not tamper with this String, and load it as it is
	 *          on the client side. Tampering with the String to scrape out any
	 *          specific html/javascript components may result in incorrect
	 *          results on our portal, or may also lead to your site being
	 *          marked as invalid.</b>
	 */
	public $contextCode;

	/**
	 * The Base64 encoded String, which contains the native metadata info. This
	 * info is the same as the "template" created on the InMobi dashboard,
	 * containing the K-V pair info of fields such as "title", "subtitle",
	 * "icon", "screenshots" etc.
	 */
	public $pubContent;

	/**
	 * Use this method to check if this object has all the required parameters
	 * present. If this method returns false, the object generated after JSON
	 * parsing would be discarded.
	 * 
	 * @return True, If the mandatory params are present.False, otherwise.
	 */
	public function isValid() {
		$isValid = true;
		if(ResponseValidator::isStringValid($this->contextCode) == false) {
			$isValid = false;
		}
		else if(ResponseValidator::isStringValid($this->ns) == false) {
			$isValid = false;
		}
		else if(ResponseValidator::isStringValid($this->pubContent) == false) {
			$isValid = false;
		}
		return $isValid;
	}

	/**
	 * Use this method to convert the Base64 encoded pubContent to a JsonObject.
	 * Please use jsonObject.get("<key-name>") to obtain the required metadata
	 * value.
	 * 
	 * @return
	 */
	public function convertPubContentToJsonObject() {
		if(ResponseValidator::isStringValid($this->pubContent) == true) {
			return base64_decode($this->pubContent);
		}
		return null;
	}

}

?>

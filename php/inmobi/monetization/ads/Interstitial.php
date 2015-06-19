<?php

require_once(dirname(__FILE__)."/Banner.php");
/**
 * Publishers may use this class to request for Interstitial ads.
 * 
 * @note Interstitials are full screen ads.
 * @author rishabhchowdhary
 * 
 */
class Interstitial extends Banner {

	function __construct() {
		parent::__construct();
		$this->requestType = AdRequest::INTERSTITIAL;
     }

}

?>
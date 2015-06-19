<?php

/**
* This class represents the "site" object in ad-request parameter. 
* Please pass the propertyId as obtained from inmobi portal.
* The site object is mandatory. This object requires the id field in order to serve ads to a specific site.
*/
class Property {
    /**
    * This is the alphanumeric string, as obtained from InMobi.
    */
    public $propertyId;

    function __construct($propertyId) {
        $this->propertyId = $propertyId;
     } 
     /**
     * Returns whether this Property instance is valid for an ad request or not.
     */
     public function isValid() {
        return StubValidator::isStringValid($this->propertyId);
     }
}

/**
* This class represents the "banner" information, as required in the ad-request.
* A banner object primarily contains the ad-slot information, which is mandatory for Banner/Interstitial ad requests.
* An optional value of the "position" for a banner/interstitial ad may be provided.
* The banner object is required under the imp object to describe the type of ad requested.
* It is essential if the ad requested is rich media, or more.
*/
class Slot {
    /**
    * This is an integer value for the "slot" id, mandatory for the ad request. 
    * Example -> 15 for 320x50 size, 10 for 300x250 size, etc.
    */
    public $adSize;
    /**
    * An optional value for banner position in your app/web-page.
    */
    public $position;
    /**
    * @param $size The $adSize, or the "integer" value of the ad-slot
    */
    function __construct($size,$pos) {
        $this->adSize = $size;
        $this->position = $pos;
     } 
    /**
    * Returns if the slot object has the valid mandatory parameters for an ad-request.
    */
     public function isValid() {
        //position is an optinal field
        return StubValidator::isIntegerValid($this->adSize);
     }
}
/**
* This class represent the "imp" object in the ad-request.
* The imp object describes the ad position or the impression being requested.
*/
class Impression {
    public $noOfAds = 1;
    protected $isInterstitial = false;
    public $displayManager = "s_imapi_php";
    public $displayManagerVersion = "1.0.0";
    public $slot;

    function __construct($s) {
        $slot = $s;
    }
    static function getImpressionObjectWithSlot($s) {
        $imp = new Impression();
        $imp->slot = $s;
        return $imp;
    }
    public function isValid() {
        //only check if slot is valid here..
        if($this->slot == null) return false;
        if(gettype($this->slot) != "object") return false;
        return $this->slot->isValid();
    }
}

/**
* The geo object collects the user’s latitude, longitude, and accuracy details. 
* This object, and all of its parameters, are optional.
**/
class Geo {
    /**
    * This variable represents the latitude of the device.
    * Accepted range : [-90,90]
    */
    public $lat;
    /**
    * This variable represents the longitude of the device.
    * Accepted range: [-180,180]
    */
    public $lon;
    /**
    * This variable represents the accuracy associated with the geo-coordinates.
    */
    public $accuracy;

    function __construct($lat,$lon,$accu) {
        $this->lat = $lat;
        $this->lon = $lon;
        $this->accuracy = $accu;
     } 
     /**
     * Returns true if this object is valid for an ad-request, false otherwise.
     */
     public function isValid() {
        if (StubValidator::isDoubleValid($this->lat) != true || 
            StubValidator::isDoubleValid($this->lon) != true || 
            StubValidator::isIntegerValid($this->accuracy) != true) {
            return false;
        }
        //check for lat-lon ranges
        if($this->lat <= -90 || $this->lat >= 90) return false;
        if($this->lon <= -180 || $this->lat >= 180) return false;
        if($this->accuracy < 0) return false;

        return true;
     }
}
/**
 * The device provides rmation pertaining to a device, including its hardware,
 * platform, location, and carrier.</br>
 * <p>
 * <b>Note:</b>
 * </p>
 * <b>1.</b> The User-Agent, and carrierIP are mandatory rmation, without which
 * a request will always be terminated.</br> <b>2.</b> The Carrier IP must be a
 * valid Mobile Country code, and <b>not</b> of your local-wifi/LAN/WAN.</br>
 * Please refer for additional details:
 * http://en.wikipedia.org/wiki/Mobile_country_code</br> For eg: 10.14.x.y, or
 * 192.168.x.y are internal IPs, and hence passing them would terminate the
 * request.</br> <b>3.</b>The User Agent string passed should be a valid,
 * WebView User Agent of the device, for which ads are being requested.
 * 
 * @author rishabhchowdhary
 * 
 */
class Device {
    /**
     * 
     * The String value containing the carrier IP. Must be a valid carrier IP ,of the device.
     */
    public $carrierIP ;
    /**
    * The Browser/WebView User Agent String of the device. Must not be empty.
    **/
    public $userAgent ;
    /**
    * The Google Play advertising identifier as obtained from the device.
    **/
    public $gpId ;
    /**
    * The The ANDROID_ID value of the device, must be passed as SHA-1 or MD5 hashed value.
    **/
    public $androidId ;
    /**
    * The Apple advertising identifier value, for the device.
    **/
    public $idfa ;
    /**
    * The Geo, as set for this instance.
    **/
    public $geo ;

    /**
    * iOS
    * This parameter is used only for iOS 6, and above, devices. It indicates if Limit Ad Tracking is enabled or disabled by the user. The values of this can be: Yes (1) or No (0).
    * Android
    * This parameter indicates whether the user wants to opt out of Interest based Ads, and can be enabled or disabled by user. The values of this can be: Yes (1) or No (0). 
    * More information about this is present here.
    * Note: Although this is not a mandatory parameter, it is important for adhering to policies regarding user opt-out, and to address user privacy concerns.
    **/
    public $adTrackingDisabled;

    function __construct($carrierIP,$userAgent) {

        $carrierIP = $carrierIP;
        $userAgent = $userAgent;
        $gpId = null;
        $androidId = null;
        $idfa = null;
        $geo = null;
        $adTrackingDisabled = false;
     } 

     /**
     * Use this method to check if this Object has all the required parameters
     * present, to be used to construct a JSON request. The required parameters
     * would be specific to an ad-format.
     * 
     * @return If the mandatory params are present, then true, otherwise false.
     */
     public function isValid() {
        if(StubValidator::isStringValid($this->carrierIP) == false) return false; 
        if(StubValidator::isStringValid($this->userAgent) == false) return false;
        //put checks for device id later on..
        return true;
     }
}
//TODO
class UserSegment {

}
/**
 * This class represents the data and segment s together allow data about the
 * user to be passed to the ad server through the ad request.
 * 
 * Data can be from multiple sources, as specified by the data �s id field.
 * This , and all of its parameters, are optional.
 * 
 * @author rishabhchowdhary
 * 
 */
class Data {
    /**
    * The data provider ID String, as set. 
    **/
    public $ID;
    /**
    * The data provider Name, as set.
    **/
    public $name;
    /**
    * The UserSegment info, having the required demographic, for
    *            additional targeting purposes. This is an optional field.
    **/
    public $userSegment;

    function __construct() {
        $ID = null;
        $name = null;
        $userSegment = null;
     } 

     static function getDataWithParams($id,$n,$seg) {
        $d = new Data();
        $d->ID = $id;
        $d->name = $n;
        $d->userSegment = $seg;
        return $d;
     }
     public function isValid() {
        // TODO
        return true;
     }
}


/**
 * This class represents the User, to be send as part of the inmobi ad request.
 * The optional values include - yob, gender, and Data.
 * 
 * @author rishabhchowdhary
 * 
 */
class User {
    /**
    * The year-of-birth of the user, optional demo info.
    **/
    public $yearOfBirth;
    /**
    * The Gender of the user, optional demographic info. Default value is 
    **/
    public $gender;

    /**
    * The Data, having the required data provider, and segment
     *            info. This is optional.
    **/
    public $data;

    function __construct() {
        $yearOfBirth = null;
        $gender = null;
        $data = null;
     } 
     
     static function getUserWithParams($yob,$g,$d) {
        $user = new User();
        $user->yearOfBirth = $yob;
        $user->gender = $g;
        $user->data = $d;

        return $user;
     }
     public function isValid() {
        // TOOD
        return true;
     }
}

abstract class StubValidator {
     /**
     * Use this function to validate if the input object is of type "string", 
     * and is non-null & non-empty
     * @param $string The input object, to check for "string" type.
     * @return true, if the object is valid string, else false.
     **/
    static function isStringValid($string) {
        if($string == null) return false;
        if (empty(trim($string)) == true) {
            return false;
        }
        if(gettype($string) != "string") {
            return false;
        }
        return true;
    }
     /**
     * Use this function to validate if the input object is of type "integer", 
     * and is non-null.
     * @param $integer The input object, to check for "integer" type.
     * @return true, if the object is valid integer, else false.
     **/
    static function isIntegerValid($integer) {
        if($integer == null) return false;
        if(gettype($integer) != "integer") {
            return false;
        }
        return true;
    }
     /**
     * Use this function to validate if the input object is of type "double", 
     * and is non-null.
     * @param $double The input object, to check for "double" type.
     * @return true, if the object is valid double, else false.
     **/
    static function isDoubleValid($double) {
        if($double == null) return false;
        if(gettype($double) != "double") {
            return false;
        }
        return true;
    }
}

?>
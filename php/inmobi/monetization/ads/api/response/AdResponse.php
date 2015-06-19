<?php


abstract class ResponseValidator {
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


abstract class AdResponse {
	public abstract function isValid();
}

?>
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
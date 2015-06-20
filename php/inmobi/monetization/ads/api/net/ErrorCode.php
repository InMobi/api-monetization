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
 class ErrorCode {

 	/**
	 * The error is unknown. Please look at responseMsg for any further details.
	 */
	const UNKNOWN = 0;
	/**
	 * An I/O exception occured. Please check if the response is coming from a
	 * valid InMobi production endpoint.
	 */
	const INTERNAL_ERROR = 1;
	/**
	 * Please check if the endpoint is correct.
	 */
	const MALFORMED_URL = 2;
	/**
	 * The request contains invalid parameters, or the parameters couldn't be
	 * identified by InMobi. <br/>
	 * <b>InMobi property ID</b>: Please check if the passed String value is
	 * 'activated' on InMobi UI.<br/>
	 * <b> Carrier IP</b: Please check if a valid Mobile Country code was passed
	 * in the request. Localhost values such as "10.x.y.z" or "192.x.y.z" are
	 * disallowed.<br/>
	 * <b> User Agent</b>: Please pass in a valid Mobile User Agent. Passing any
	 * desktop User Agent is disallowed, and request will be terminated by
	 * InMobi.
	 */
	const INVALID_REQUEST = 3;
	/**
	 * Served has returned a no-fill, no action required here. Publishers are
	 * expected to try requesting ads in future.
	 */
	const NO_FILL = 4;
	/**
	 * Coulnd't connect to the server, or the request timed out.
	 */
	const TIME_OUT = 5;
	/**
	 * InMobi server gateway experienced too many requests, and hence a gateway
	 * time out occured. Please ignore this error, and try requesting ads after
	 * some time.
	 */
	const GATEWAY_TIME_OUT = 6;

	public $errorCode = UNKNOWN;
	public $errorMsg = ""; 

	function __construct($code,$msg) {
      
      $this->errorCode = $code;
      $this->errorMsg = $msg;
     }
     
     const NO_FILLMSG = "Server returned a no fill.No action required.";

     const INVALID_REQUEST_MSG = "Please check your request object for mandatory parameters such as PropertyID, Mobile User Agent & Carrier IP.";

     const GATEWAY_TIMEOUT_MSG = "Gateway time out occured. Please retry your request after some time.";

     const INTERNAL_ERROR_MSG = "Unexpected response received:";
}
?>
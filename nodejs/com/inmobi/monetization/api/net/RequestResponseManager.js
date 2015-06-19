var http = require('http');
var request = require('request');
var ErrorCode = require('./ErrorCode.js');
var Utils = require('../utils/Utils.js');

function RequestResponseManager() {
	this.errorCode = null;
}
RequestResponseManager.prototype.fetchResponse = function(requestJson,useragent,carrierIP,success,fail) {
	if(typeof(success) != "function" 
        || typeof(fail) != "function") {
      return null;
  	}

  	if(Utils.isStringValid(requestJson) == false
  		|| Utils.isStringValid(useragent) == false
  		|| Utils.isStringValid(carrierIP) == false) {
  		fail(new ErrorCode("Please provide valid request POST body, user-agent & carrierIP fields.",ErrorCode.UNKNOWN));
  		return;
  	}
  	console.log("here:" + requestJson)
	request({
	    url: "http://api.w.inmobi.com/showad/v2",
	    method: "POST",
	    headers: {
	        "content-type": "application/json", 
	        "x-forwarded-for":carrierIP,
	        "x-device-user-agent": useragent
	    },
	    body: requestJson
	}, function (error, response, body){
	    console.log("got");
	    if(error == null) {
	    	var statusCode = response.statusCode;
	    	if(statusCode == 200) {
	    		console.log("fetched a succesful response in manager");
	    		success(body);
	    	} else if(statusCode == 204) {
	    		fail(new ErrorCode("Server returned a no-fill, no action required.",ErrorCode.NO_FILL));
	    	} else if(statusCode == 400) {
	    		console.log("invalid req")
	    		fail(new ErrorCode("Invalid request. Please validate your mandatory params - CarrierIP, UserAgent & InMobi Property ID.",ErrorCode.INVALID_REQUEST));
	    	} else if(statusCode == 504) {
	    		fail(new ErrorCode("Gateway timeout occured, please request ads after some time.",ErrorCode.GATEWAY_TIME_OUT));
	    	} else {
	    		fail(new ErrorCode("Receive status Code:" + statusCode,ErrorCode.IO_EXCEPTION));
	    	}
	    } else {
	    	fail(error);
	    }
	});
}
module.exports = RequestResponseManager;
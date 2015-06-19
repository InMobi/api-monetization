var AdFormat = require('./AdFormat.js');
var NativeResponseParser = require('../api/response/parser/NativeResponseParser.js');
var AdRequest = require('../api/request/enums/AdRequest.js');
var ErrorCode = require('../api/net/ErrorCode.js');
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Publishers can use this class instance to request Native ads from InMobi. 
// @note Please pass the mandatory request params.

// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Native() {
  AdFormat.apply(this,Array.prototype.slice.call(arguments));
  this.requestType = AdRequest.NATIVE;
  this.jsonParser = new NativeResponseParser();
}
Native.prototype = new AdFormat();


//private function, publishers should call loadRequest only.
Native.prototype.loadRequestInternal = function(request,success,fail) {

  if(typeof(success) != "function" 
        || typeof(fail) != "function") {
      return;
  }
  
  var errorCode = this.errorCode;
  var manager = this.manager;
  var jsonParser = this.jsonParser;
  adsArray = null;
  if(this.canLoadRequest(request,this.requestType) == true) {
      this.manager.fetchResponse(request.toJSON(),
        request.device.useragent,
        request.device.carrierIP,
        function nativeSuccess(response) {
            errorCode = manager.errorCode;
            //console.log("in uscccess of banner: " + response);
            if(response != null && typeof(response) == "string" && errorCode == null) {
            //response received without any error.. now parse the response
                adsArray = jsonParser.parseResponse(response);

                if(adsArray == null || typeof(adsArray) != "object") {
                  errorCode = new ErrorCode("XML Parsing error occured.",ErrorCode.IO_EXCEPTION);
                } else if(typeof(adsArray.length) == "undefined") {
                  errorCode = new ErrorCode("Invalid response received.",ErrorCode.IO_EXCEPTION);
                } else if(adsArray.length == 0) {
                  errorCode = new ErrorCode("Server returned a no-fill,no action required.",ErrorCode.NO_FILL);
                }
                if(errorCode != null) {
                  fail(errorCode);
                } else {
                  success(adsArray);
                }
          
            } else {
                fail(errorCode);
            }
        },function nativeFail(error) {
            errorCode = error;
            fail(error);
        });
      
    } else {

      fail(this.errorCode);
    }
  
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Call this method to load a native ad.
  // @note Please make sure the request object has all the mandatory params
  // To check if a request object is valid, please call Request.isValid() method
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Native.prototype.loadRequest = function(request,success,fail) {
  return this.loadRequestInternal(request,success,fail);
}

module.exports = Native;

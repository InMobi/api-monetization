var AdFormat = require('./AdFormat.js')
var AdRequest = require('../api/request/enums/AdRequest.js');
var BannerResponseParser = require('../api/response/parser/BannerResponseParser.js')
var ErrorCode = require('../api/net/ErrorCode.js');
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Publishers can use this class instance to request banner ads from InMobi. 
// @note Please pass the mandatory request params.

// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Banner() {
  AdFormat.apply(this,Array.prototype.slice.call(arguments));
  this.requestType = AdRequest.BANNER;
  this.xmlParser = new BannerResponseParser();
}
Banner.prototype = new AdFormat();

//private function, publishers should call loadRequest only.
Banner.prototype.loadRequestInternal = function(request,success,fail) {
  if(typeof(success) != "function" 
        || typeof(fail) != "function") {
      return;
  }
  var errorCode = this.errorCode;
  var manager = this.manager;
  var xmlParser = this.xmlParser;
  adsArray = null;
  if(this.canLoadRequest(request,this.requestType) == true) {
      this.manager.fetchResponse(request.toJSON(),
        request.device.useragent,
        request.device.carrierIP,
        function bannerSuccess(response) {
            errorCode = manager.errorCode;
            console.log("in uscccess of banner: ");
            if(response != null && typeof(response) == "string" && errorCode == null) {
            //response received without any error.. now parse the response
                xmlParser.parseResponse(response,function parseResponse(adsArray) {
                    console.log("ad parsed:" + adsArray)
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
                });
               
          
            } else {
                fail(errorCode);
            }
        },function bannerFail(error) {
            errorCode = error;
            fail(error);
        });
      
    } else {

      fail(this.errorCode);
    }
  
}
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Call this method to load a banner ad.
  // @note If Interstitial class instance is used, the super class(Banner) automatically 
  // requests for an Interstitial ad.
  // @note Please make sure the request object has all the mandatory params
  // To check if a request object is valid, please call Request.isValid() method
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Banner.prototype.loadRequest = function(request,success,fail) {
    this.loadRequestInternal(request,success,fail);
      
  }
module.exports = Banner;
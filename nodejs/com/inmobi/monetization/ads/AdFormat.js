var ErrorCode = require('../api/net/ErrorCode.js');
var RequestResponseManager = require('../api/net/RequestResponseManager.js');
var AdRequest = require('../api/request/enums/AdRequest.js');
var Request = require('../api/request/Request.js');

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This is the abstract base class for InMobi ad formats. The class must be
// extended( please look at Banner,Interstitial classes for perusal.

// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function AdFormat() {
  this.errorCode = null;
  this.requestType = AdRequest.NONE;
  this.isRequestInProgress = false;
  this.manager = new RequestResponseManager();
}
//this function checks if the input request object contains the necessary mandatory parameters for a request or not.

AdFormat.prototype.canLoadRequest = function(request,requestType) {
  if(request == null) {
      this.errorCode = new ErrorCode("Request object cannot be empty",ErrorCode.INVALID_REQUEST) ;
      return false;
  }
  if(typeof(request) != "object") {
      this.errorCode = new ErrorCode("Request object cannot be empty",ErrorCode.INVALID_REQUEST) ;
      return false;
  }
  if(request.constructor.name != "Request") {
        this.errorCode = new ErrorCode("Object must be an instance of Request class",ErrorCode.INVALID_REQUEST);
        return false;
  }
  request.requestType = requestType;
  if(request.isValid() == false) {
    this.errorCode = new ErrorCode("Please provide a valid Request object. Please check if the mandatory parameter: CarrierIP, userAgent & propertyID are valid",ErrorCode.INVALID_REQUEST); 
    return false;
  }
  this.isRequestInProgress = true;
  return true 
}

module.exports = AdFormat;
require_relative '../api/net/ErrorCode.rb'
require_relative '../api/net/RequestResponseManager.rb'
require_relative '../api/request/Enums.rb'
require_relative '../api/request/JSONPayloadCreator.rb'
require_relative '../api/request/Request.rb'

########################################################################
# This is the abstract base class for InMobi ad formats. The class must be
# extended( please look at Banner,Interstitial classes for perusal.

# @author Rishabh Chowdhary
########################################################################
class AdFormat
  def initialize
    @errorCode = nil
    @requestType = AdRequest::NONE
    @isRequestInProgress = false
    @manager = RequestResponseManager.new()
  end
  
  attr_reader :errorCode

  protected
  def loadRequestInternal(request)
      response = nil
      if(canLoadRequest(request,@requestType) == true)
          response = @manager.fetchResponse(request.toJSON(),request.device.userAgent,request.device.carrierIP)
          @errorCode = @manager.errorCode
      end
      return response
  end

  def canLoadRequest(request,requestType)
      if(request == nil)
        errorCode = ErrorCode.new("Request object cannot be empty",ErrorCode::INVALID_REQUEST) 
        return false
      end
      if(request.instance_of?(Request) == false)
        errorCode = ErrorCode.new("Object must be an instance of Request class",ErrorCode::INVALID_REQUEST) 
        return false
      end
      request.requestType = @requestType
      if(request.isValid() == false)
        errorCode = ErrorCode.new("Please provide a valid Request object. Please check if the mandatory parameter: CarrierIP, userAgent & propertyID are valid",ErrorCode::INVALID_REQUEST) 
        return false
      end
      @isRequestInProgress = true
      return true 
  end

end
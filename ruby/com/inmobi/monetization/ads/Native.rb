require_relative('AdFormat.rb')
require_relative('../api/response/NativeResponseParser.rb')

########################################################################
#Publishers can use this class instance to request Native ads from InMobi. 
# @note Please pass the mandatory request params.

# @author Rishabh Chowdhary
########################################################################

class Native < AdFormat
  def initialize
  	super()
  	@requestType = AdRequest::NATIVE
    @jsonParser = NativeResponseParser.new()
  end

  protected
  alias :super_loadRequestInternal :loadRequestInternal
  alias :super_canLoadRequest :canLoadRequest
  def loadRequestInternal(request)
      adsArray = nil
      response = super_loadRequestInternal(request)
       
     if(response != nil && errorCode == nil)
        adsArray = @jsonParser.parseResponse(response)
        if(adsArray == nil)
          @errorCode = ErrorCode.new("JSON Parsing error occured.",ErrorCode::IO_EXCEPTION)
        elsif (adsArray.empty?)
            @errorCode = ErrorCode.new("Server returned a no-fill,no action required.",ErrorCode::NO_FILL)
        end
     end
       return adsArray
  end

  public
  ########################################################################
  # Call this method to load a native ad.
  # @note Please make sure the request object has all the mandatory params
  # To check if a request object is valid, please call Request.isValid() method
  ########################################################################
  def loadRequest(request)
    if(super_canLoadRequest(request,@requestType))
          loadRequestInternal(request)
      end
  end

end
require_relative('AdFormat.rb')
require_relative('../api/response/BannerResponseParser.rb')

########################################################################
#Publishers can use this class instance to request banner ads from InMobi. 
# @note Please pass the mandatory request params.

# @author Rishabh Chowdhary
########################################################################

class Banner < AdFormat
  def initialize 
  	super()
  	@requestType = AdRequest::BANNER
    @xmlParser = BannerResponseParser.new()
  end

  protected
  alias :super_loadRequestInternal :loadRequestInternal
  alias :super_canLoadRequest :canLoadRequest
  def loadRequestInternal(request)
      adsArray = nil
       response = super_loadRequestInternal(request)
       if(response != nil && errorCode == nil)
          adsArray = @xmlParser.parseResponse(response)
          if(adsArray == nil)
            @errorCode = ErrorCode.new("XML Parsing error occured.",ErrorCode::IO_EXCEPTION)
          elsif (adsArray.empty?)
              @errorCode = ErrorCode.new("Server returned a no-fill,no action required.",ErrorCode::NO_FILL)
          end
       end
       return adsArray
  end
  
  
  public
  ########################################################################
  # Call this method to load a banner ad.
  # @note If Interstitial class instance is used, the super class(Banner) automatically 
  # requests for an Interstitial ad.
  # @note Please make sure the request object has all the mandatory params
  # To check if a request object is valid, please call Request.isValid() method
  ########################################################################
  def loadRequest(request)
      return loadRequestInternal(request)
  end

end
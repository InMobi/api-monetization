require_relative('NativeResponse.rb');
require 'json'

########################################################################
#This class can be used to obtain an ArrayList of NativeResponse objects, from
# the raw response(as String), obtained from the InMobi API 2.0 Server
# response.
# @author Rishabh Chowdhary
########################################################################
class NativeResponseParser
	public
	def parseResponse(response)
		
		adsArray = nil
		if(Utils.isStringValid(response)) 
			
			begin
				adsArray = Array.new()
    			adsJson = JSON.parse(response)
    			if(adsJson.empty? == false)
    				ads = adsJson['ads'];

    				if(ads != nil)
    					ads.each { |adJson|
    					ad = NativeResponse.new()
    					ad.pubContent = adJson['pubContent']
    					ad.contextCode = adJson['contextCode']
    					ad.namespace = adJson['namespace']
    					if(ad.isValid())
    						adsArray.push(ad)
    					end
    				}
    				end
    			end
			rescue
     			adsArray = nil
			end
			
		end
		return adsArray
	end
end
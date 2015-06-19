require_relative('Stubs.rb')
require_relative('Enums.rb')
require_relative('JSONPayloadCreator.rb')
########################################################################
 #The top-level ad request is required to contain at least the site containing
 # the unique site ID, and the device containing the client IP address and user
 # agent information.

 # If you're using one of the classes under com.inmobi.monetization.ads to
 # request ads, you must provide a valid Request.
# @author Rishabh Chowdhary
########################################################################
class Request
	def initialize
		@impression = nil
		@device = nil
		@user = nil
		@property = nil
		@requestType = AdRequest::NONE
	end
	attr_accessor :property
	attr_accessor :impression
	attr_accessor :device
	attr_accessor :user
	attr_accessor :requestType
	public
	def self.builder(property,impression,device,user)
		r = Request.new()
		r.property = property
		r.impression = impression
		r.user = user
		r.device = device
		return r
	end

	
	def isValid
		valid = false

		if(property != nil && property.isValid() == true)
			if(device != nil && device.isValid() == true)
				if(requestType == AdRequest::NATIVE)
					valid = true
				elsif (requestType == AdRequest::BANNER || requestType == AdRequest::INTERSTITIAL)
					if(impression != nil && impression.isValid())
						valid = true
					end

				end
				
			end	
		end
		return valid
	end
	def toJSON
		if(self.isValid == true)
			return JSONPayloadCreator.fetchJSON(self)
		end
		return nil
	end

end
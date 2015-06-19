require_relative('AdResponse.rb')
########################################################################
# This class represents a Banner/Interstitial ad response object
# @author Rishabh Chowdhary
########################################################################
class BannerResponse < AdResponse
	attr_accessor :CDATA
	attr_accessor :actionType
	attr_accessor :actionName
	attr_accessor :isRichMedia
	attr_accessor :adSize
	attr_accessor :adURL
	def initialize
		super()
		@CDATA = nil
		@actionName = nil
		@actionType = 0
		@isRichMedia = false
		@adSize = nil
		@adURL = nil
	end
	public
	def isValid
		if(Utils.isStringValid(@CDATA) == false) 
			return false
		end
			return true
	end
	def to_s
		return "AdURL:" << adURL << "\nactionType:" << actionType.to_s << "\nactionName:" << actionName << "\nadSize:" << "{width:" << adSize.width.to_s << ",height:" << adSize.height.to_s << "}" << "\nisRichMedia:" << isRichMedia.to_s << "\n\nCDATA:" << @CDATA
	end
end

class AdSize
	public
	def initialize(w,h)
		@width = 0, @height = 0
		if(Utils.isStringValid(w))
			@width = w.to_i
		elsif (Utils.isFixnumValid(w))
			@width = w
		end
		if(Utils.isStringValid(h))
			@height = h.to_i
		elsif (Utils.isFixnumValid(w))
			@height = h
		end
	end
	attr_accessor :width
	attr_accessor :height

end
require_relative 'Banner.rb'

########################################################################
#Publishers can use this class instance to request Interstitial ads from InMobi. 
# @note Please pass the mandatory request params.

# @author Rishabh Chowdhary
########################################################################

class Interstitial < Banner
	def initialize
		super()
		@requestType = AdRequest::INTERSTITIAL;
	end
end
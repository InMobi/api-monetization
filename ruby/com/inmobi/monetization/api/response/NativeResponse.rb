require_relative('AdResponse')
require 'base64'

########################################################################
# This class represents a Native Ad Response object
# @author Rishabh Chowdhary
########################################################################
class NativeResponse < AdResponse

	def initialize
		@pubContent = nil
		@namespace = nil
		@contextCode = nil
	end
	public
	attr_accessor :pubContent
	attr_accessor :namespace
	attr_accessor :contextCode

	# Returns a base64 decode JSON String of the pubContent
	#NOTE: This should be the same exact JSON template as
	# setup by you on the InMobi dashboard for a Native Ad.
	def convertPubContentToJSON
		if(Utils.isStringValid(@pubContent))
			return Base64.decode64(@pubContent);
		end
		return nil
	end

	def isValid
		if(Utils.isStringValid(@pubContent) && Utils.isStringValid(@namespace) && Utils.isStringValid(@contextCode) )
			return true
		end
		return false
	end
end
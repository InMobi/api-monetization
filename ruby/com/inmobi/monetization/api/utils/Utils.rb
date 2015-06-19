########################################################################
# Util class function, for checking validity of data types
# @author Rishabh Chowdhary
########################################################################
class Utils
	#Returns true if the input type is nil, or empty or not of type String
	#Returns false otherwise
	def self.isStringValid(input)
		if input == nil
			return false
		end

		if input.instance_of?(String) == true
			# Return true as the input object is not of a string
			return input.strip.empty? ? false : true
		end
		return false
	end

	def self.isFixnumValid(input)
		if input == nil
			return false
		end
		if input.instance_of?(Fixnum) == true
			# Return true as the input object is not of a string
			if input <= 0 
				return false
			end
			return true
		end
		return false
	end

	def self.isFloatValid(input)
		if input == nil
			return false
		end
		if input.instance_of?(Float) == true
			# Return true as the input object is not of a string
			return true
		end
		return false
	end
end


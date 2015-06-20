#######################################################################################
#Copyright © 2015 InMobi Technologies Pte. Ltd. All rights reserved.
#
#                           MIT License
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#THE SOFTWARE.
#
#InMobi Monetization Library SUBCOMPONENTS:
#
#The InMobi Monetization Library contains subcomponents with separate copyright
#notices and license terms. Your use of the source code for the these
#subcomponents is subject to the terms and conditions of the following
#licenses.
#
#————————-————————-————————-————————-————————-————————-————————-————————-————————-————————-
#License for REXML:
#
#REXML is copyrighted free software by Sean Russell <ser@germane-software.com>.
#You can redistribute it and/or modify it under either the terms of the GPL
#(see GPL.txt file), or the conditions below:
#
# 1. You may make and give away verbatim copies of the source form of the
#     software without restriction, provided that you duplicate all of the
#     original copyright notices and associated disclaimers.
#
# 2. You may modify your copy of the software in any way, provided that
#     you do at least ONE of the following:
#
#      a) place your modifications in the Public Domain or otherwise
#        make them Freely Available, such as by posting said
#	  modifications to Usenet or an equivalent medium, or by allowing
#	  the author to include your modifications in the software.
#
#       b) use the modified software only within your corporation or
#          organization.
#
#       c) rename any non-standard executables so the names do not conflict
#	  with standard executables, which must also be provided.
#
#       d) make other distribution arrangements with the author.
#
#  3. You may distribute the software in object code or executable
#     form, provided that you do at least ONE of the following:
#
#       a) distribute the executables and library files of the software,
#	  together with instructions (in the manual page or equivalent)
#	  on where to get the original distribution.
#
#      b) accompany the distribution with the machine-readable source of
#	  the software.
#
#       c) give non-standard executables non-standard names, with
#          instructions on where to get the original software distribution.
#
#       d) make other distribution arrangements with the author.
#
#  4. You may modify and include the part of the software into any other
#     software (possibly commercial).  But some files in the distribution
#     are not written by the author, so that they are not under this terms.
#
#     All files of this sort are located under the contrib/ directory.
#     See each file for the copying condition.
#
#  5. The scripts and library files supplied as input to or produced as 
#     output from the software do not automatically fall under the
#     copyright of the software, but belong to whomever generated them, 
#     and may be sold commercially, and may be aggregated with this
#     software.
#
#  6. THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#     IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#     WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#     PURPOSE.

#######################################################################################
require_relative('../Utils/Utils.rb')
require_relative('Enums.rb')

########################################################################
# This class contains info about the InMobi Property, which is mandatory as
# part of the InMobi Ad Request.

# @author Rishabh Chowdhary
########################################################################
class Property

	attr_accessor :propertyId
	def initialize(propertyId)
		@propertyId = propertyId
	end
	def isValid
		# Check if the propertyId is valid.
		return Utils.isStringValid(propertyId)
	end
end
########################################################################
#This class represents the "banner" object, required under the "imp" object to
# describe the type of ad requested.</br>
# 
# It is a must to provide a valid ad-slot if you're requesting
# Banner/Interstitial ads. If in case you have not provided a valid value, the
# back end system would choose a default value.

# @author Rishabh Chowdhary
########################################################################
class Slot
	def initialize(adSize,position)
		@adSize = adSize
		@position = position
	end
	attr_accessor :adSize
	attr_accessor :position
	def isValid
		return Utils.isFixnumValid(adSize)
	end
end
########################################################################
# The imp object describes the ad position or the impression being requested.


# @author Rishabh Chowdhary
########################################################################
class Impression
	def initialize(slot)
		@slot = slot
		@noOfAds = 1
		@displayManager = "s_im_ruby"
		@displayManagerVersion = "1.0.0"
	end
	def noOfAds(ads)
		if ads > 0 && ads <= 3
			@noOfAds = ads
		end
	end
	def isValid
		if( slot != nil)
			return slot.isValid()
		end
		return false
	end

	attr_reader :noOfAds
	attr_reader :displayManager
	attr_reader :displayManagerVersion
	attr_accessor :slot
			
end
########################################################################
# The geo object collects the user’s latitude, longitude, and accuracy details.
# This object, and all of its parameters, are optional.

# @author Rishabh Chowdhary
########################################################################
class Geo
	def initialize(lat,lon,accu)
		@latitude = lat
		@longitude = lon
		@accuracy = accu
	end

	def isValid
		if(Utils.isFloatValid(latitude) == true && Utils.isFloatValid(longitude) == true && Utils.isFixnumValid(accuracy) == true )
			if( (latitude > -90) && (latitude < 90) && (longitude > -180) && (longitude < 180))
				return true
			end
		end
		return false
	end

	attr_accessor :latitude
	attr_accessor :longitude
	attr_accessor :accuracy

end
########################################################################
#The device  provides rmation pertaining to a device, including its
# hardware, platform, location, and carrier.</br>
# The User-Agent, and carrierIP are mandatory rmation, without
# which a request will always be terminated.</br> <b>2.</b> The Carrier IP must
# be a valid Mobile Country code, and <b>not</b> of your
# local-wifi/LAN/WAN.</br> Please refer for additional details:
# http://en.wikipedia.org/wiki/Mobile_country_code</br> For eg: 10.14.x.y, or
# 192.168.x.y are internal IPs, and hence passing them would terminate the
# request.</br> <b>3.</b>The User Agent string passed should be a valid,
# WebView User Agent of the device, for which ads are being requested.

# @author Rishabh Chowdhary
########################################################################
class Device

	def initialize
		@carrierIP = nil
		@userAgent = nil
		@gpid = nil
		@idfa = nil
		@geo = nil
		@adTrackingDisabled = false
	end

	def isValid
		if Utils.isStringValid(carrierIP) == false
			return false
		end
		if Utils.isStringValid(userAgent) == false
			return false
		end
		return true
	end

	attr_accessor :carrierIP
	attr_accessor :userAgent
	attr_accessor :gpid
	attr_accessor :idfa
	attr_accessor :geo
end

########################################################################
#TODO
#This class represents the data and segment s together allow data about
# the user to be passed to the ad server through the ad request.
# 
# Data can be from multiple sources, as specified by the data ’s id
# field. This , and all of its parameters, are optional.
# @author Rishabh Chowdhary
########################################################################
class Data
	def initialize
		providerId = nil
		name = nil
		userSegment = nil
	end
	attr_accessor :providerId
	attr_accessor :name
	attr_accessor :userSegment
end

########################################################################
#TODO
# This class defines the user segments, to be passed as an optional parameter
# in InMobi Ad request. Segment objects convey specific units of information
# from the provider identified, in the parent data object

# @author Rishabh Chowdhary
########################################################################
class UserSegment

end

########################################################################
#TODO
# This class represents the User, to be send as part of the inmobi ad
# request. The optional values include - yob, gender, and Data.

# @author Rishabh Chowdhary
########################################################################
class User
	def initialize
		@yearOfBirth = nil
		@gender = Gender::UNKNOWN
		@data = nil
	end
	attr_accessor :yearOfBirth
	attr_accessor :gender
	attr_accessor :data
	def isValid
		return true
	end
end



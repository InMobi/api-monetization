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
require 'json'
require_relative 'Request.rb'
require_relative '../utils/Utils.rb'
########################################################################
# This method constructs a JsonObject, depending on the request parameters passed.

# @note The request object needs to have valid arguments, depending on the AdRequestType

# You should check if the request.isValid() returns true, as this method internally
# validates the request & proceeds if & only the request object is valid for the AdRequestType.
# @param request The request object, for which a JSON would be constructed
# @param type The request type, one of Banner, Interstitial or Native ads
# @return JsonObject which is used as POST Body in the InMobi API 2.0 Ad Request. 
# TODO User demography as part of JSON API request.

# @author Rishabh Chowdhary
########################################################################
class JSONPayloadCreator
	public
	def self.fetchJSON(request)
		if(request == nil)
			return nil
		elsif request.instance_of?(Request) == false
			return nil
		elsif request.isValid() == false
			return nil
		end
		#The main object will have collection of all sub-objects for ad-request
		mainObject = Hash.new()

		if(request.requestType != AdRequest::NATIVE) 
			mainObject['responseformat'] = 'axml'
		else
			mainObject['responseformat'] = 'native'
		end

		pHash = JSONPayloadCreator.fetchProperty(request.property)
		if(pHash != nil)
			mainObject['site'] = pHash
		end
		pImp = JSONPayloadCreator::fetchImpression(request.impression,request.requestType)
		if(pImp != nil)
			mainObject['imp'] = pImp
		end
		pDevice = JSONPayloadCreator::fetchDevice(request.device)
		if(pDevice != nil)
			mainObject['device'] = pDevice
		end
		pUser = JSONPayloadCreator::fetchUser(request.user)
		if(pUser != nil && pUser.empty? == false) 
			mainObject['user'] = pUser
		end

		return mainObject.to_json	
	end

	private

	def self.fetchProperty(property)
		pHash = Hash.new()
		pHash['id'] = property.propertyId
		return pHash
	end

	def self.fetchImpression(impression,requestType)
		impArray = Array.new();
		impHash = Hash.new()
		impHash['ads'] = impression.noOfAds
		impHash['displaymanager'] = impression.displayManager
		impHash['displaymanagerversion'] = impression.displayManagerVersion
		if(requestType == AdRequest::INTERSTITIAL)
			impHash['adtype'] = "int"
		end
		bannerHash = Hash.new()
		if(requestType != AdRequest::NATIVE)
			impHash['adsize'] = impression.slot.adSize
			if (Utils.isStringValid(impression.slot.position))
			impHash['pos'] = impression.slot.position
			end
			impHash['banner'] = bannerHash
		end
		
		impArray.push(impHash)
		return impArray
	end

	def self.fetchDevice(device)
		deviceHash = Hash.new()
		deviceHash['ip'] = device.carrierIP
		deviceHash['ua'] = device.userAgent
		if (Utils.isStringValid(device.gpid))
			deviceHash['gpid'] = device.gpid
		end
		if (Utils.isStringValid(device.idfa))
			deviceHash['ida'] = device.idfa
		end
		if(device.adTrackingDisabled == true) 
			deviceHash['ida'] = true
		else
			deviceHash['ida'] = false	
		end
		geo = device.geo
		if(geo != nil && geo.isValid())
			geoHash = Hash.new();
			geoHash['lat'] = geo.latitude
			geoHash['lon'] = geo.longitude
			geoHash['accu'] = geo.accuracy
			deviceHash['geo'] = geoHash
		end

		return deviceHash
	end
	def self.fetchUser(user)
		userHash = nil;
		if(user != nil) 
			userHash = Hash.new();
			if(Utils.isFixnumValid(user.yearOfBirth))
				userHash['yob'] = user.yearOfBirth;
			end
			gender = user.gender
			if (gender == Gender::MALE) 
					userHash['gender'] = 'M';
				elsif (gender == Gender::FEMALE)
					userHash['gender'] = 'F';
			end
		end
		return userHash;
	end

end
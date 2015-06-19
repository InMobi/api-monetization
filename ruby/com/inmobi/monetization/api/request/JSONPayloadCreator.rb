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
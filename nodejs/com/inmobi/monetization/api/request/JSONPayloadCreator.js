var Request = require('./Request.js');
var AdRequest = require('../request/enums/AdRequest.js');
var Utils = require('../utils/Utils.js');
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This method constructs a JsonObject, depending on the request parameters passed.

// @note The request object needs to have valid arguments, depending on the AdRequestType

// You should check if the request.isValid() returns true, as this method internally
// validates the request & proceeds if & only the request object is valid for the AdRequestType.
// @param request The request object, for which a JSON would be constructed
// @param type The request type, one of Banner, Interstitial or Native ads
// @return JsonObject which is used as POST Body in the InMobi API 2.0 Ad Request. 
// TODO User demography as part of JSON API request.

// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function JSONPayloadCreator() {	
}
//internal method
JSONPayloadCreator.fetchProperty = function(property) {
	var propertyArray = {};
	propertyArray['id'] = property.propertyId;
	return propertyArray;
}
//internal method
JSONPayloadCreator.fetchImpression = function(impression,requestType) {
	var impArray = {};
	impArray['ads'] = impression.noOfAds;
	impArray['displaymanager'] = impression.displayManager;
	impArray['displaymanagerversion'] = impression.displayManagerVersion;
	if(requestType == AdRequest.INTERSTITIAL) {
		impArray['adtype'] = "int";
	}
	
	if(requestType != AdRequest.NATIVE) {
		bannerArray = {};
		bannerArray['adsize'] = impression.slot.adSize;
		if (Utils.isStringValid(impression.slot.position)) {
			bannerArray['pos'] = impression.slot.position;
		}
		impArray['banner'] = bannerArray;
	}
	
	return [impArray]; // Impression is an array representation
}	
//internal method
JSONPayloadCreator.fetchDevice = function(device) {
	var deviceArray = {};
	deviceArray['ip'] = device.carrierIP;
	deviceArray['ua'] = device.useragent;
	if (Utils.isStringValid(device.gpid)) {
		deviceArray['gpid'] = device.gpid;
	}
	if (Utils.isStringValid(device.idfa)) {
		deviceArray['ida'] = device.idfa;
	}
	if(device.adTrackingDisabled == true) {
		deviceArray['adt'] = 1;
	} else {
		deviceArray['adt'] = 0;
	}
	geo = device.geo;
	if(geo != null && geo.isValid()) {
		geoArray = {};
		geoArray['lat'] = geo.latitude;
		geoArray['lon'] = geo.longitude;
		geoArray['accu'] = geo.accuracy;
		deviceArray['geo'] = geoArray;
	}

	return deviceArray;
}

JSONPayloadCreator.fetchJSON = function(request) {
	if(request != null && typeof(request) == "object" && request.constructor.name =="Request" && request.isValid()) {
		mainObjectArray = {};

		if(request.requestType != AdRequest.NATIVE) {
			mainObjectArray['responseformat'] = 'axml';
		}
		else {
			mainObjectArray['responseformat'] = 'native';
		}

		pHash = JSONPayloadCreator.fetchProperty(request.property);
		if(pHash != null) {
			mainObjectArray['site'] = pHash;
		}
		pImp = JSONPayloadCreator.fetchImpression(request.impression,request.requestType)
		if(pImp != null) {
			mainObjectArray['imp'] = pImp;
		}
		pDevice = JSONPayloadCreator.fetchDevice(request.device);
		if(pDevice != null) {
			mainObjectArray['device'] = pDevice;
		}
		return JSON.stringify(mainObjectArray);
	}
	return null;
}

module.exports = JSONPayloadCreator;

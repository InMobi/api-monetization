//require_relative('Stubs.rb')
var AdRequest = require('./enums/AdRequest.js');
var Property = require('./ad/Property.js');
var Impression = require('./ad/Impression.js');
var Device = require('./ad/Device.js');
var User = require('./ad/User.js');
var JSONPayloadCreator = require('./JSONPayloadCreator.js')
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //The top-level ad request is required to contain at least the site containing
 // the unique site ID, and the device containing the client IP address and user
 // agent information.

 // If you're using one of the classes under com.inmobi.monetization.ads to
 // request ads, you must provide a valid Request.
// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function Request(property,impression,device,user) {
		this.impression = impression;
		this.device = device;
		this.user = user;
		this.property = property;
		this.requestType = AdRequest.NONE;
}

Request.prototype.isValid = function() {
	valid = false;
	
	if(this.property != null && typeof(this.property) == "object" && this.property.isValid() == true) {
		if(this.device != null && typeof(this.device) == "object" && this.device.isValid() == true) {
			if(this.requestType == AdRequest.NATIVE)
				valid = true;
			else if (this.requestType == AdRequest.BANNER || this.requestType == AdRequest.INTERSTITIAL) {
				if(this.impression != null && typeof(this.impression) == "object" && this.impression.isValid()) {
					valid = true;
				}
			}
		}
	}
	return valid;
}

Request.prototype.toJSON = function() {
	if(this.isValid() == true) {
		return JSONPayloadCreator.fetchJSON(this);
	}
	return null;
}	


module.exports = Request;
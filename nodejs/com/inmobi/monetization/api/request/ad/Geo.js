////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The geo object collects the user’s latitude, longitude, and accuracy details.
// This object, and all of its parameters, are optional.

// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var Utils = require('../../utils/Utils.js');

function Geo(lat,lon,accu) {
	//
    this.latitude = lat;
    this.longitude = lon;
    this.accuracy = accu;
}

Geo.prototype.isValid = function() {
	if(Utils.isNumberValid(this.latitude) == false 
		|| Utils.isNumberValid(this.longitude) == false
		|| Utils.isNumberValid(this.accuracy) == false ) {
		return false;
	}
	
	if(this.latitude < -90 || this.latitude > 90) return false;
	if(this.longitude < -180 || this.longitude > 180) return false;
	if(this.accuracy <= 0) return false;

	return true;
}


module.exports =  Geo;

var AdResponse = require('./AdResponse.js');
var Utils = require('../../utils/Utils.js');

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This class represents a Native Ad Response object
// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function NativeResponse() {
	AdResponse.apply(this,Array.prototype.slice.call(arguments));
	this.pubContent = null;
	this.namespace = null;
	this.contextCode = null;
}
NativeResponse.prototype.isValid = function() {
	if(Utils.isStringValid(this.pubContent) 
		&& Utils.isStringValid(this.contextCode)
		&& Utils.isStringValid(this.namespace)) {
		return true;
	}
	return false;
}
NativeResponse.prototype.convertPubContentToJSON = function() {
	if(Utils.isStringValid(this.pubContent)) {
		return new Buffer(this.pubContent, 'base64').toString('ascii');
	}
	return null;
}

module.exports = NativeResponse;
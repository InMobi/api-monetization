var AdResponse = require('./AdResponse.js');
var Utils = require('../../utils/Utils.js');
var AdSize = require('./AdSize.js');

function BannerResponse() {
	AdResponse.apply(this,Array.prototype.slice.call(arguments));
	this.CDATA = null;
	this.actionType = null;
	this.actionName = null;
	this.isRichMedia = false;
	this.adSize = null;
	this.adURL = null;
}
BannerResponse.prototype = new AdResponse();
BannerResponse.prototype.isValid = function() {
		if(Utils.isStringValid(this.CDATA) == true) {
			return true;
		}
		return false;
}
module.exports = BannerResponse;


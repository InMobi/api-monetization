
var Utils = require('../../utils/Utils.js')
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This class represents a Banner/Interstitial ad response object
// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function AdSize(w,h) {
	this.width = 0;
	this.height = 0;
	if(Utils.isStringValid(w)) {
		this.width = parseInt(w);
	} else if(Utils.isNumberValid(w)) {
		this.width = w;
	}
	if(Utils.isStringValid(h)) {
		this.height = parseInt(h);
	} else if(Utils.isNumberValid(h)) {
		this.height = w;
	}
}
AdSize.prototype.isValid = function() {
		if(Utils.isNumberValid(this.width) == false || Utils.isNumberValid(this.height) == false) {
			return false;
		}
		if(this.width <= 0 || this.height <= 0) {
			return false;
		}
		return true;

}
module.exports = AdSize;


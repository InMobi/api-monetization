////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//This class represents the "banner" object, required under the "imp" object to
// describe the type of ad requested.</br>
// 
// It is a must to provide a valid ad-slot if you're requesting
// Banner/Interstitial ads. If in case you have not provided a valid value, the
// back end system would choose a default value.

// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var Utils = require('../../utils/Utils.js');

function Slot(size,position) {
	//
    this.adSize = size;
    this.position = position;
}

Slot.prototype.isValid = function() {
	if(Utils.isNumberValid(this.adSize) == false) return false;
	if(this.adSize <= 0) return false;
	return true;
}

module.exports = Slot;



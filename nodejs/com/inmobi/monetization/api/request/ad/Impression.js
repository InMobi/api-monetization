////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The imp object describes the ad position or the impression being requested.

// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var Slot = require('./Slot.js');
var Utils = require('../../utils/Utils.js');

function Impression(slot) {
    this.slot = slot;

    //do not modify unless explicitly required
	this.noOfAds = 1;
	this.displayManager = "s_im_nodejs";
	this.displayManagerVersion = "1.0.0";
}

Impression.prototype.isValid = function() {
    var slot = this.slot;
    if(slot != null && typeof(slot) == "object") {
    	if(slot.constructor.name == "Slot") {
    		return slot.isValid();
    	}
    }
    return false;
}

module.exports = Impression;
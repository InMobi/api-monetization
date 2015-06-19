var Banner = require('./Banner.js')
var AdRequest = require('../api/request/enums/AdRequest.js');
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Publishers can use this class instance to request Interstitial ads from InMobi. 
// @note Please pass the mandatory request params.

// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Interstitial() {
	Banner.apply(this,Array.prototype.slice.call(arguments));
	this.requestType = AdRequest.INTERSTITIAL;
}
Interstitial.prototype = new Banner();

// Interstitial.prototype.loadRequest = function(request,success,fail) {
// 	return Banner.prototype.loadRequestInternal.call(this, request,success,fail);
// }

module.exports = Interstitial;
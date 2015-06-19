var Enum = require('enum');
var AdRequest = new Enum(
	{
		'NONE' : 0,
		'BANNER' : 1,
		'INTERSTITIAL' : 2,
		'NATIVE' : 3,
	}
	);
module.exports = AdRequest;
var Enum = require('enum');
var SexualOrientation = new Enum(
	{
		'NONE' : 0,
		'STRAIGHT' : 1,
		'GAY' : 2,
		'BISEXUAL' : 3,
		'UNKNOWN' : 4
	}
	);
module.exports = SexualOrientation;
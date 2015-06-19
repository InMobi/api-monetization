var Enum = require('enum');
var Gender = new Enum(
	{
		'UNKNOWN' : 0,
		'MALE' : 1,
		'FEMALE' : 2
	}
	);
module.exports = Gender;
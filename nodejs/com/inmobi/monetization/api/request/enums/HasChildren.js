var Enum = require('enum');
var HasChildren = new Enum(
	{
		'TRUE' : 0,
		'FALSE' : 1,
		'UNKNOWN' : 2
	}
	);
module.exports = HasChildren;
var Enum = require('enum');
var Ethnicity = new Enum(
	{
		'HISPANIC' : 0,
		'AFRICANAMERICAN' : 1,
		'ASIAN' : 2,
		'CAUCASIAN' : 3,
		'OTHER' : 4,
		'UNKNOWN' : 5
	}
	);
module.exports = Ethnicity;
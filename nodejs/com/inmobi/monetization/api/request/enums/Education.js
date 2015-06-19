var Enum = require('enum');
var Education = new Enum(
	{
		'HIGHSCHOOLORLESS' : 0,
		'COLLEGEORGRADUATE' : 1,
		'POSTGRADUATEORABOVE' : 2,
		'UNKNOWN' : 3,
	}
	);
module.exports = Education;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Util class function, for checking validity of data types
// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var Utils = {};
	//Returns true if the input type is nil, or empty or not of type String
	//Returns false otherwise
Utils.isStringValid = function(input) {
		if(input == null)
			return false;
		if(typeof(input) != "string")
			return false;

		if(input.trim() == "")
			return false;

		return true;
}
Utils.isNumberValid = function(input) {
		if(input == null)
			return false;
		if(typeof(input) != "number")
			return false;

		return true;
}

module.exports = Utils;
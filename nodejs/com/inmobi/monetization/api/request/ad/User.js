////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TODO
//This class represents the data and segment s together allow data about
// the user to be passed to the ad server through the ad request.
// 
// Data can be from multiple sources, as specified by the data ’s id
// field. This , and all of its parameters, are optional.

// @author Rishabh Chowdhary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var Data = require('./Data.js');
var Gender = require('../enums/Gender.js');

function User() {
	
    this.gender = Gender.UNKNOWN;
    this.name = null;
    this.data = null;
}

User.prototype.isValid = function() {
    	return false;
}

module.exports = User;



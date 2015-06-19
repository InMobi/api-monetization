var test = require('unit.js');
var Utils = require("../../com/inmobi/monetization/api/utils/Utils.js")

describe('TestUtils', function () {

  it('should correctly run the specific Util cases for string', function () {
      // assertions here
		test.assert(Utils.isStringValid() == false);
		test.assert(Utils.isStringValid(null) == false);
 		test.assert(Utils.isStringValid(1) == false);
 		test.assert(Utils.isStringValid("")== false);
 		test.assert(Utils.isStringValid("   ") == false);
 		test.assert(Utils.isStringValid(1.00) == false);
 		test.assert(Utils.isStringValid(false) == false);
 		test.assert(Utils.isStringValid("sdf") == true);
 		test.assert(Utils.isStringValid({}) == false);
 		test.assert(Utils.isStringValid(" this is a response ") == true);
    });
   it('should correctly run the specific Util cases for integer', function () {
      // assertions here
		test.assert(Utils.isNumberValid() == false);
		test.assert(Utils.isNumberValid(null) == false);
 		test.assert(Utils.isNumberValid(1) == true);
 		test.assert(Utils.isNumberValid("")== false);
 		test.assert(Utils.isNumberValid("   ") == false);
 		test.assert(Utils.isNumberValid(1.00) == true);
 		test.assert(Utils.isNumberValid(12323123) == true);
 		test.assert(Utils.isNumberValid(12.123) == true);
 		test.assert(Utils.isNumberValid(false) == false);
 		test.assert(Utils.isNumberValid("sdf") == false);
 		test.assert(Utils.isNumberValid({}) == false);
 		test.assert(Utils.isNumberValid(" this is a response ") == false);
    }); 

  });

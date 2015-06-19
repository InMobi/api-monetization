require_relative "../../com/inmobi/monetization/api/utils/Utils.rb"

require "test/unit"

class TestUtils < Test::Unit::TestCase
 	def testStringUtil
 		assert_equal(false,Utils.isStringValid(nil));
 		assert_equal(false,Utils.isStringValid(1));
 		assert_equal(false,Utils.isStringValid(""));
 		assert_equal(false,Utils.isStringValid("   "));
 		assert_equal(false,Utils.isStringValid(1.00));
 		assert_equal(false,Utils.isStringValid(false));
 		assert_equal(true,Utils.isStringValid("sdf"));
 		assert_equal(false,Utils.isStringValid(Object.new));
 		assert_equal(true,Utils.isStringValid(" this is a response "));
 	end
 	def testFixnumUtil
 		assert_equal(false,Utils.isFixnumValid(nil));
 		assert_equal(false,Utils.isFixnumValid(""));
 		assert_equal(false,Utils.isFixnumValid("this is a string"));
 		assert_equal(false,Utils.isFixnumValid(76.1124));
 		assert_equal(false,Utils.isFixnumValid(Object.new()));
 		assert_equal(true,Utils.isFixnumValid(123));
 		assert_equal(true,Utils.isFixnumValid(234234));
 	end
 	def testFloatUtil
 		assert_equal(false,Utils.isFloatValid(nil));
 		assert_equal(false,Utils.isFloatValid(""));
 		assert_equal(false,Utils.isFloatValid("this is a string"));
 		assert_equal(false,Utils.isFloatValid(Object.new));
		assert_equal(false,Utils.isFloatValid(123));
		assert_equal(false,Utils.isFloatValid(123123));
		assert_equal(true,Utils.isFloatValid(12.233));
		assert_equal(true,Utils.isFloatValid(121231.2331));
 	end
end
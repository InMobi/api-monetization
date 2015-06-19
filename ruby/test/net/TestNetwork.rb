require_relative "../../com/inmobi/monetization/api/net/ErrorCode.rb"
require_relative "../../com/inmobi/monetization/api/net/RequestResponseManager.rb"

require "test/unit"

class TestStubs < Test::Unit::TestCase

  def testErrorCode
  	ec = ErrorCode.new(nil,nil);
  	code = ErrorCode::NO_FILL;
  	ec = ErrorCode.new("",code);
  	assert_equal(code,ec.errorCode);

  	code = ErrorCode::INVALID_REQUEST;
  	ec = ErrorCode.new("ERRORMSG",code);
  	assert_equal(code,ec.errorCode);
  	assert_equal("ERRORMSG",ec.errorMsg);
  	code = ErrorCode::TIME_OUT;
  	ec = ErrorCode.new("",code);
  	assert_equal(code,ec.errorCode);
  	code = ErrorCode::GATEWAY_TIME_OUT;
  	ec = ErrorCode.new("",code);
  	assert_equal(code,ec.errorCode);
	code = ErrorCode::IO_EXCEPTION;
  	ec = ErrorCode.new("",code);
  	assert_equal(code,ec.errorCode);
  end

  def testRequestResponseMgr
  	mgr = RequestResponseManager.new();
  	assert_equal(nil,mgr.fetchResponse(nil,nil,nil));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  	assert_equal(nil,mgr.fetchResponse("","",""));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  	assert_equal(nil,mgr.fetchResponse(" ","  ","  "));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  	assert_equal(nil,mgr.fetchResponse(1,1,1));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  	assert_equal(nil,mgr.fetchResponse(Object.new,1,1.12323));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  	assert_equal(nil,mgr.fetchResponse("postBody","user-agent","87.12.1.1"));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  	assert_equal(nil,mgr.fetchResponse("postBody","Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3","6.0.0.1"));
  	assert_equal(ErrorCode::INVALID_REQUEST,mgr.errorCode.errorCode);
  end
end
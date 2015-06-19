var ErrorCode = require( "../../com/inmobi/monetization/api/net/ErrorCode.js");
var RequestResponseManager = require( "../../com/inmobi/monetization/api/net/RequestResponseManager.js");
var test = require('unit.js');

describe('testErrorCode', function () {

  it('should correctly run the specific error code cases', function () {
        ec = new ErrorCode(null == null);
        code = ErrorCode.NO_FILL;
        ec = new ErrorCode("",code);
        test.assert(code == ec.errorCode);

        code = ErrorCode.INVALID_REQUEST ;
        ec = new ErrorCode("ERRORMSG",code);
        test.assert(code == ec.errorCode);
        test.assert("ERRORMSG",ec.errorMsg);
        code = ErrorCode.TIME_OUT;
        ec = new ErrorCode("",code);
        test.assert(code == ec.errorCode);
        code = ErrorCode.GATEWAY_TIME_OUT;
        ec = new ErrorCode("",code);
        test.assert(code == ec.errorCode);
        code = ErrorCode.IO_EXCEPTION;
        ec = new ErrorCode("",code);
        test.assert(code == ec.errorCode);
    }); 

    it('should correctly run the RequestResponseMgr cases', function () {
        mgr = new RequestResponseManager();
        test.assert(null == mgr.fetchResponse(null,null,null));
        test.assert(null == mgr.fetchResponse("postBody","user-agent","87.12.1.1"," ",{}));
        test.assert(null == mgr.fetchResponse("","","",null,null));
        test.assert(null == mgr.fetchResponse("postBody","user-agent","87.12.1.1",false,{}));
        test.assert(null == mgr.fetchResponse(" ","  ","  ",1,1.5));
        test.assert(null == mgr.fetchResponse("postBody","user-agent","87.12.1.1",1,{}));
        test.assert(null == mgr.fetchResponse(1,1,1,1,"sdf"));
        test.assert(null == mgr.fetchResponse("postBody","user-agent","87.12.1.1",null,{}));
        test.assert(null == mgr.fetchResponse({},1,1.12323,function() {},{}));
        test.assert(null == mgr.fetchResponse("postBody","user-agent","87.12.1.1",{},null));
        test.assert(null == mgr.fetchResponse("postBody","user-agent","87.12.1.1",{}));
        test.assert(null == mgr.fetchResponse("postBody","user-agent","87.12.1.1",true,{}));
        test.assert(null == mgr.fetchResponse("postBody","Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3","6.0.0.1"));
        mgr.fetchResponse("","user-agent","  ",function success() {
          test.fail();
        },function fail(error) {test.assert(error != null)});
        mgr.fetchResponse("","",null,function success() {
          test.fail();
        },function fail(error) {test.assert(error != null)});
        mgr.fetchResponse(null,"",null,function success() {
          test.fail();
        },function fail(error) {test.assert(error != null)});
        mgr.fetchResponse("",null,null,function success() {
          test.fail();
        },function fail(error) {test.assert(error != null)});
        mgr.fetchResponse(null,null,null,function success() {
          test.fail();
        },function fail(error) {test.assert(error != null)});
        mgr.fetchResponse("  ","  ","  ",function success() {
          test.fail();
        },function fail(error) {test.assert(error != null)});
        mgr.fetchResponse(1,"  ","  ",function success() {
          test.fail();
        },function fail(error) {test.assert(error != null)});
        mgr.fetchResponse(1,{},"  ",function success() {
          test.fail();
        },function fail(error) {test.assert(error != null)});
        mgr.fetchResponse(1,"  ",false,function success() {
          test.fail();
        },function fail(error) {test.assert(error != null)});

        mgr.fetchResponse("","user-agent","6.0.0.0",function success() {
          test.fail();
        },function fail(error) {test.assert(error != null)});
        mgr.fetchResponse("","Mozilla/5.0 (iPhone; CPU iPhone OS 7_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Mobile/9A405","6.0.0.0",function success() {
          test.fail();
        },function fail(error) {test.assert(error != null)});
        mgr.fetchResponse("{\"responseformat\":\"native\",\"site\":{\"id\”:\”prop_id\”},\”imp\":[{\"ads\":1,\"displaymanager\":\"s_im_nodejs\",\"displaymanagerversion\":\"1.0.0\"}],\"device\":{\"ip\":\"87.84.221.50\",\"ua\":\"Mozilla/5.0 (iPhone; CPU iPhone OS 7_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Mobile/9A405\"}}","Mozilla/5.0 (iPhone; CPU iPhone OS 7_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Mobile/9A405","6.0.0.0",function success() {
          test.fail();
        },function fail(error) {console.log("hereeeee");test.assert(error != null)});

    });

  });

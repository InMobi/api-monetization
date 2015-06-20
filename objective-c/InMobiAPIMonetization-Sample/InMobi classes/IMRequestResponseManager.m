//
//  IMRequestResponse.m
//  Native ad sample
//
//////////////////////////////////////////////////////////////////////
//Copyright © 2015 InMobi Technologies Pte. Ltd. All rights reserved.

//MIT License

//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////

#import "IMRequestResponseManager.h"
#import "GTMBase64Private.h"
@implementation IMRequestResponseManager

#define IM_AD_SERVER_URL @"http://api.w.inmobi.com/showad/v2"

//- (void)sendSuccessCallback:(NSData *)rootObject successBlock:(void (^)(id rootObj))success {
//    if (success != nil) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            success(rootObject);
//        });
//    }
//}
//
//- (void)sendFailureCallback:(NSError *)error failureBlock:(void (^)(NSError *e))failed {
//    if (failed != nil) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            failed(error);
//        });
//        
//    }
//}

- (id)sendInMobiAdRequest:(NSData *)payloadJSON deviceIP:(NSString *)carrierIP
           deviceUserAgent:(NSString *)ua {
    self.error = nil;
    NSLog(@"%@",[[NSString alloc] initWithData:payloadJSON encoding:NSUTF8StringEncoding]);
    if (payloadJSON && [IMUtils isValidString:carrierIP]
        && [IMUtils isValidString:ua]) {
        NSError *e = nil;
        NSMutableURLRequest *urlReq = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:IM_AD_SERVER_URL]];
        [urlReq setTimeoutInterval:60];
        urlReq.HTTPMethod = @"POST";
        urlReq.HTTPBody = payloadJSON;
        [urlReq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
       // [urlReq setValue:carrierIP forHTTPHeaderField:@"x-forwarded-for"];
       // [urlReq setValue:ua forHTTPHeaderField:@"user-agent"];
        
        NSHTTPURLResponse *urlResponse = nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:urlReq returningResponse:&urlResponse error:&e];
        long statusCode = [urlResponse statusCode];
        
        if (responseData && !e && statusCode == 200) {
            return responseData;
            
        } else {
            if (statusCode == 204) {
                self.error = [IMError errorWithDomain:@"Inmobi" code:IM_NO_FILL userInfo:@{NSLocalizedDescriptionKey: @"Server returned a no-fill. No Action required."}];
            } else if(statusCode == 400) {
                self.error = [IMError errorWithDomain:@"Inmobi" code:IM_INVALID_REQUEST userInfo:@{NSLocalizedDescriptionKey: @"Invalid request. Please check your mandatory params for validity - Device User-agent, Carrier-IP & InMobi property id."}];
            }
            else {
                self.error = [IMError errorWithDomain:@"Inmobi" code:IM_UNKNOWN userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Request failed with statusCode=%ld",statusCode]}];
            }
            return nil;
        }
        
    }
    self.error = [IMError errorWithDomain:@"InMobi" code:IM_IO_EXCEPTION userInfo:[NSDictionary dictionaryWithObject:@"Please provide valid values for http request." forKey:NSLocalizedDescriptionKey]];
    return nil;

}

@end

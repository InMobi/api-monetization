//
//  IMRequestResponse.m
//  Native ad sample
//

//

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
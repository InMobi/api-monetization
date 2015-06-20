//
//  IMAdFormat.m
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
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

#import "IMAdFormat.h"
#import "IMRequestResponseManager.h"

@interface IMAdFormat () {
    IMRequestResponseManager *manager;
}

@end

@implementation IMAdFormat
@synthesize requestType,error;

- (id)init {
    if (self = [super init]) {
        manager = [[IMRequestResponseManager alloc] init];
        requestType = IMAdRequestTypeNone;
    }
    return self;
}

- (void)successCallback:(void (^)(NSArray *ads))success withAds:(NSArray *)ads {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (success != nil) {
            success(ads);
        }
    });
}
- (void)failureCallback:(void (^)(NSError *e))failed {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (failed != nil) {
            failed(error);
        }
    });
}

- (NSData *)loadRequestInternal:(IMRequest *)request {
    NSData *response = [manager sendInMobiAdRequest:[request toJSON] deviceIP:request.device.carrierIP deviceUserAgent:request.device.userAgent];
    //NSLog(@"response=%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    self.error = manager.error;
    _isRequestInProgress = NO;
    return response;
}
- (BOOL)canLoadRequest:(IMRequest *)request {

    BOOL load = YES;
    if (request != nil) {
        request.requestType = requestType;
        if ([request isValid]) {
            if (!_isRequestInProgress) {
                _isRequestInProgress = YES;
            } else {
                load = NO;
            }
        } else {
            load = NO;
        }
    } else {
        load = NO;
    }
    return load;
}


@end

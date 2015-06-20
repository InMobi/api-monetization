//
//  IMNative.m
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
//

#import "IMNative.h"
#import "IMNativeResponseParser.h"

@interface IMNative () {
    IMNativeResponseParser *parser;
}

@end

@implementation IMNative

- (id)init {
    if (self = [super init]) {
        requestType = IMAdRequestTypeNative;
        parser = [[IMNativeResponseParser alloc] init];
    }
    return self;
}

- (void)loadRequest:(IMRequest *)request
       successBlock:(void (^)(NSArray *ads))success
       failureBlock:(void (^)(NSError *e))failed {
    @synchronized(self) {
        if (success && failed) {
            if ([super canLoadRequest:request]) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSData *response = [super loadRequestInternal:request];
                    if (response && !error) {
                        NSArray *ads = [parser parseAdsFromResponse:response];
                        if (ads && [ads count] > 0) {
                            [super successCallback:success withAds:ads];
                        } else {
                            self.error = [IMError errorWithDomain:@"Inmobi" code:IM_NO_FILL userInfo:@{NSLocalizedDescriptionKey: @"Server returned a no-fill. No Action required."}];
                            [super failureCallback:failed];
                        }
                    } else {
                        if (!error) {
                            self.error = [IMError errorWithDomain:@"Inmobi" code:IM_IO_EXCEPTION userInfo:@{NSLocalizedDescriptionKey: @"No ads received."}];
                        }
                        [super failureCallback:failed];
                    }
                });
            } else {
                [super failureCallback:failed];
            }
        } else {
            NSLog(@"Please provide non-null blocks.");
        }
    }
}

@end

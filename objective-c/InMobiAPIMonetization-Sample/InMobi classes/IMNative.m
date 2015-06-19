//
//  IMNative.m
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
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

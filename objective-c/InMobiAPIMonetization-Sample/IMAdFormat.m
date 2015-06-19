//
//  IMAdFormat.m
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

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

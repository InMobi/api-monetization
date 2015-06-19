//
//  IMAdFormat.h
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMRequest.h"
#import "IMError.h"

@interface IMAdFormat : NSObject {
    IMAdRequestType requestType;
    IMError *error;
}

@property(nonatomic,readonly) BOOL isRequestInProgress;
@property(nonatomic,readonly) IMAdRequestType requestType;
@property(nonatomic,retain) IMError *error;

- (NSData *)loadRequestInternal:(IMRequest *)request;

- (BOOL)canLoadRequest:(IMRequest *)request;
;
- (void)successCallback:(void (^)(NSArray *ads))success withAds:(NSArray *)ads;
- (void)failureCallback:(void (^)(NSError *e))failed;
@end

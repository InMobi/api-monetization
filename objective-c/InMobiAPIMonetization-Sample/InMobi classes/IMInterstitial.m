//
//  IMInterstitial.m
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import "IMInterstitial.h"

@implementation IMInterstitial

- (id)init {
    if (self = [super init]) {
        requestType = IMAdRequestTypeInterstitial;
    }
    return self;
}

@end

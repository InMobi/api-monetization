//
//  IMNative.h
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMAdFormat.h"

@interface IMNative : IMAdFormat

- (void)loadRequest:(IMRequest *)request
       successBlock:(void (^)(NSArray *ads))success
       failureBlock:(void (^)(NSError *e))failed;

@end

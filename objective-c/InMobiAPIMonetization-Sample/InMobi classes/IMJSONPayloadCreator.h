//
//  IMJSONPayloadCreator.h
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IMRequest;
@interface IMJSONPayloadCreator : NSObject

+ (NSData *)generateRequestPayload:(IMRequest *)request;

@end

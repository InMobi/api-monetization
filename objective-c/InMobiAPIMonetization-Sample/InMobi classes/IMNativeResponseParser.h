//
//  IMNativeResponseParser.h
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMResponseStubs.h"

@interface IMNativeResponseParser : NSObject

- (NSArray *)parseAdsFromResponse:(NSData *)response;
@end

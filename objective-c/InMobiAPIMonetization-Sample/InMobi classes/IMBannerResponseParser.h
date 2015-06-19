//
//  IMBannerResponseParser.h
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMResponseStubs.h"

@interface IMBannerResponseParser : NSObject <NSXMLParserDelegate>
- (NSArray *)parseAdsFromResponse:(NSData *)response;
@end

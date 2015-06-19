//
//  IMNativeResponseParser.m
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import "IMNativeResponseParser.h"

@implementation IMNativeResponseParser

- (NSArray *)parseAdsFromResponse:(NSData *)response {
    if (response) {
        id mainObj = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil];
        if (mainObj && [mainObj isKindOfClass:[NSDictionary class]]) {
            NSArray *ads = [(NSDictionary *)mainObj objectForKey:@"ads"];
            NSMutableArray *adsArray = [[NSMutableArray alloc] init];
            for (NSDictionary *adDictionary in ads) {
                IMNativeResponse *ad = [[IMNativeResponse alloc] init];
                ad.pubContent = [adDictionary objectForKey:@"pubContent"];
                ad.contextCode = [adDictionary objectForKey:@"contextCode"];
                ad.ns = [adDictionary objectForKey:@"namespace"];
                if ([ad isValid]) {
                    [adsArray addObject:ad];
                }
            }
            return adsArray;
        }
    }
    return NULL;
}

@end

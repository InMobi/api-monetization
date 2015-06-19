//
//  IMResponseStubs.m
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import "IMResponseStubs.h"
#import "IMUtils.h"
#import "GTMBase64Private.h"

@implementation IMResponse

- (BOOL)isValid {
    return true;
}

@end

@implementation IMBannerResponse

- (BOOL)isValid {
    return [IMUtils isValidString:self.CDATA];
}

@end

@implementation IMNativeResponse

- (BOOL)isValid {
    if ([IMUtils isValidString:self.pubContent] &&
        [IMUtils isValidString:self.contextCode]
        && [IMUtils isValidString:self.ns]) {
        return YES;
    }
    return NO;
}
- (NSString *)convertPubContentToJSON {
    if ([IMUtils isValidString:self.pubContent]) {
        return [[NSString alloc] initWithData:[GTMBase64Private decodeString:self.pubContent] encoding:NSUTF8StringEncoding];
    }
    return NULL;
}

@end

@implementation IMAdSize

- (id)init {
    if (self = [super init]) {
        self.width = self.height = 0;
    }
    return self;
}

- (BOOL)isValid {
    if (self.width > 0 && self.height > 0) {
        return YES;
    }
    return NO;
}

@end

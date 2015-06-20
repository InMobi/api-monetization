//
//  IMResponseStubs.m
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//
//////////////////////////////////////////////////////////////////////
//Copyright © 2015 InMobi Technologies Pte. Ltd. All rights reserved.

//MIT License

//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////

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

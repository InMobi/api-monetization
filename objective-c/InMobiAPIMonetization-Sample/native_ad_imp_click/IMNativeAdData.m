//
//  IMNativeAdData.m
//  Native ad sample
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

#import "IMNativeAdData.h"

@implementation IMNativeAdData
@synthesize ns,contextCode,additionalParams;
@synthesize isImpressionCountingFinished,isClickCountingFinished;

- (id)initWithNS:(NSString *)n contextCode:(NSString *)ctc
            additionalParams:(NSDictionary *)params {
    self = [super init];
    if (self) {
        self.ns = n;
        self.contextCode = ctc;
        self.additionalParams = params;
        self.ts = [IMNativeAdData currentTimeStamp];
    }
    return self;
}
#pragma mark NSCoding protocol utils

- (void)encodeWithCoder:(NSCoder *)aCoder {
    @try {
        [aCoder encodeObject:ns forKey:@"ns"];
        [aCoder encodeObject:contextCode forKey:@"contextCode"];
        [aCoder encodeObject:additionalParams forKey:@"additionalParams"];
        [aCoder encodeObject:[NSNumber numberWithBool:isImpressionCountingFinished] forKey:@"imp"];
        [aCoder encodeObject:[NSNumber numberWithBool:isClickCountingFinished] forKey:@"click"];
    }
    @catch (NSException *exception) {
        IMLOGGING(@"%@",exception.description);
    }
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        //initialize objects here.
        @try {
            self.ns = [aDecoder decodeObjectForKey:@"ns"];
            self.contextCode = [aDecoder decodeObjectForKey:@"contextCode"];
            self.additionalParams = [aDecoder decodeObjectForKey:@"additionalParams"];
            self.isImpressionCountingFinished = [[aDecoder decodeObjectForKey:@"imp"] boolValue];
            self.isClickCountingFinished = [[aDecoder decodeObjectForKey:@"click"] boolValue];
        }
        @catch (NSException *exception) {
            IMLOGGING(@"%@",exception.description);
        }
    }
    return self;
}

#pragma mark javascript generator methods 

- (NSString *)generateJavascriptString:(int)operationEvent {
    NSString *retStr = @"";
    if (additionalParams == nil) {
        retStr = [NSString stringWithFormat:@"%@<script>%@recordEvent(%d)</script>",contextCode,ns,operationEvent];
    } else retStr = [NSString stringWithFormat:@"%@<script>%@recordEvent(%d,%@)</script>",contextCode,ns,operationEvent,[self serializeObject:additionalParams error:nil]];
    
    return retStr;
}

- (NSString *)serializeObject:(id)inObject error:(NSError **)outError {
    NSData *data = [NSJSONSerialization dataWithJSONObject:inObject options:0 error:outError];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)generateJavascriptForClickWithoutImpression {
    //where should params be passed??
    return [NSString stringWithFormat:@"%@<script>recordEvent(%d)</script>",[self generateJavascriptString:IMAdOperationTypeImpression],IMAdOperationTypeClick];
}

+ (double)currentTimeStamp {
   return (double) [[NSDate date] timeIntervalSince1970];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"namespace=%@,imp_counting=%d,click_counting=%d",ns,isImpressionCountingFinished,isClickCountingFinished];
}

@end

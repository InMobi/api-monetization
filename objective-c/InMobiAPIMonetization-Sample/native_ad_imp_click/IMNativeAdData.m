//
//  IMNativeAdData.m
//  Native ad sample
//
//

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

//
//  IMBannerResponseParser.m
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import "IMBannerResponseParser.h"

@interface IMBannerResponseParser () {
    IMBannerResponse *ad;
    NSMutableArray *ads;
    BOOL isAdURL;
}

@end

@implementation IMBannerResponseParser

- (NSArray *)parseAdsFromResponse:(NSData *)response {
    if (response != nil) {
        ads = [[NSMutableArray alloc] init];
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:response];
        // Depending on the XML document you're parsing,
        // you may want to enable these features of NSXMLParser.
        [parser setShouldProcessNamespaces:NO];
        [parser setShouldReportNamespacePrefixes:NO];
        [parser setShouldResolveExternalEntities:NO];
        parser.delegate = self;
        [parser parse];
        return ads;
    }
    return nil;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([@"Ad" isEqualToString:elementName]) {
        ad = [[IMBannerResponse alloc] init];
        if (attributeDict) {
            ad.actionName = [attributeDict objectForKey:@"actionName"];
            ad.actionType = [[attributeDict objectForKey:@"actionType"] intValue];
            if ([@"rm" isEqualToString:[attributeDict objectForKey:@"type"]]) {
                ad.isRichMedia = true;
            }
            IMAdSize *size = [[IMAdSize alloc] init];
            size.width = [[attributeDict objectForKey:@"width"] intValue];
            size.height = [[attributeDict objectForKey:@"height"] intValue];
            ad.adSize = size;
        }
    } else if([@"AdURL" isEqualToString:elementName]) {
        isAdURL = YES;
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([@"Ad" isEqualToString:elementName]) {
        if ([ad isValid]) {
            [ads addObject:ad];
        }
    }
    isAdURL = NO;
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (isAdURL) {
        ad.adURL = string;
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)_data {
    ad.CDATA = [[NSString alloc]
                  initWithData:_data encoding:NSUTF8StringEncoding];
}

@end

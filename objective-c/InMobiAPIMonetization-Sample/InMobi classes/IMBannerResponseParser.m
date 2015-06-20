//
//  IMBannerResponseParser.m
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

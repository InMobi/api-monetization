//
//  BannerView.m
//  Native ad sample
//
//  Created by Rishabh Chowdhary on 25/11/2014.
//  Copyright (c) 2014 Rishabh Chowdhary. All rights reserved.
//

#import "BannerView.h"
#import "IMRequestResponseManager.h"

@interface BannerView () <NSXMLParserDelegate,UIWebViewDelegate> {
    BOOL isRequestInProgress;
    IMRequestResponseManager *requestResponseMgr;
    UIWebView *webview;
}
@property(nonatomic,copy) NSString *CDATA;
@end

@implementation BannerView
@synthesize request,CDATA;
@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    requestResponseMgr = [[IMRequestResponseManager alloc] init];
    webview = [[UIWebView alloc] initWithFrame:self.bounds];
    webview.delegate = self;
    self.userInteractionEnabled = YES;
    [self addSubview:webview];
    return self;
}
- (void)loadBannerAd {
    @synchronized(self) {
        if (isRequestInProgress) {
            [self sendErrorCallback:[NSError errorWithDomain:@"Inmobi" code:LOAD_IN_PROGRESS_ERROR userInfo:@{NSLocalizedDescriptionKey: @"An ad request is already in progress"}]];
            return;
        }
        if (request == NULL) {
            [self sendErrorCallback:[NSError errorWithDomain:@"Inmobi" code:MANDATORY_PARAM_MISSING userInfo:@{NSLocalizedDescriptionKey: @"Request object cannot be NULL."}]];
            NSLog(@"Request object cannot be NULL");
            return;
        }
        if (![request isValid]) {
            [self sendErrorCallback:[NSError errorWithDomain:@"Inmobi" code:MANDATORY_PARAM_MISSING userInfo:@{NSLocalizedDescriptionKey: @"Request object cannot be NULL."}]];
            NSLog(@"Please provide a valid request object");
            return;
        }
        isRequestInProgress = YES;
        //[requestResponseMgr sendInMobiAdRequest:request type:IMAdRequestTypeBanner];
    }
}
#pragma mark Request response callbacks

- (void)requestResponse:(IMRequestResponseManager *)response failedToLoadWithError:(NSError *)error {
    NSLog(@"request Failed to load, error=%@",error);
    isRequestInProgress = NO;
    [self sendErrorCallback:error];
}
- (void)requestResponse:(IMRequestResponseManager *)response finishedWithData:(NSData *)data {
    //parse the response & fetch a single ad for now..
//    NSLog(@"%@",[[NSString alloc]
//                 initWithData:data encoding:NSUTF8StringEncoding]);
    CDATA = nil;
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    // Depending on the XML document you're parsing,
    // you may want to enable these features of NSXMLParser.
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    parser.delegate = self;
    [parser parse];
    //NSLog(@"response=%@",CDATA);
    if (CDATA) {
        NSLog(@"got valid response, loading in webview");
        //temporary block user interaction..
        webview.userInteractionEnabled = NO;
        [webview loadHTMLString:CDATA baseURL:nil];
    } else {
        NSLog(@"Server returned a no-fill.");
        isRequestInProgress = NO;
        [self sendErrorCallback:[NSError errorWithDomain:@"Inmobi" code:NO_FILL_ERROR userInfo:@{NSLocalizedDescriptionKey: @"Server returned a no-fill. No Action required."}]];
    }
}

#pragma NSXMLParser delegate callbacks
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)_data {
    self.CDATA = [[NSString alloc]
                          initWithData:_data encoding:NSUTF8StringEncoding];
}

#pragma mark UIWebView delegate callbacks

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)req
 navigationType:(UIWebViewNavigationType)navigationType {

    BOOL success = YES;
    NSURL *url = req.URL;
    if (navigationType == UIWebViewNavigationTypeFormSubmitted ||
        navigationType == UIWebViewNavigationTypeFormResubmitted) {
        success = YES;
    }
    if (navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [self openURLExternally:url];
        success = NO;
    }
    // for all other cases, just let the web view handle it
    if ([url isFileURL] ) {
        success = NO;
    }
    else if([[url absoluteString] isEqualToString:@"about:blank"]) {
        success = YES;
    }
    else if (![url.scheme isEqualToString: @"http"] && ![url.scheme isEqualToString:@"https"]) {
        success = NO;
    }
    return success;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (![webView isLoading]) {
        isRequestInProgress = NO;
        self.userInteractionEnabled = YES;
        webview.userInteractionEnabled = YES;
        NSLog(@"webview load completed.");
        [self sendSuccessCallback];
        //webview has finished loading, ad is now visible.
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"webview cannot load :%@",[error description]);
    isRequestInProgress = NO;
    [self sendErrorCallback:error];
}

- (void)openURLExternally:(NSURL* )url {
    UIApplication *app = [UIApplication sharedApplication];
    if([app canOpenURL:url]) {
        [app openURL:url];
    } else {
        NSLog(@"UIApplication unable to open url:%@",url);
    }
}
#pragma mark delegate callbacks

- (void)sendSuccessCallback {
    if(delegate && [delegate respondsToSelector:@selector(bannerViewFinishedLoading:)]) {
        [delegate bannerViewFinishedLoading:self];
    }
}
- (void)sendErrorCallback:(NSError *)error {
    if(delegate && [delegate respondsToSelector:@selector(bannerView:failedToLoadWithError:)]) {
        [delegate bannerView:self failedToLoadWithError:error];
    }
}

@end

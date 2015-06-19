//
//  InMobiAdOperation.m
//  Native ad sample
//
//

#import "IMAdOperation.h"

@interface IMAdOperation () {
    BOOL isRequestInProgress;
}

@end

@implementation IMAdOperation
@synthesize webviewWrapper,data,operationType,bgTask,delegate;

- (id)initWithWebView:(IMWebViewWrapper *)wrapper adData:(IMNativeAdData *)d
        operationType:(IMAdOperationType)type delegate:(id<IMAdOperationDelegate>)del
               bgTask:(UIBackgroundTaskIdentifier)identifier {
    self = [super init];
    if (self) {
        self.webviewWrapper = wrapper;
        self.data = d;
        self.operationType = type;
        self.delegate = del;
        self.bgTask = identifier;
        //set status to isExecuting, so that queue doesn't pick up the same webview again.
        if (wrapper != nil) {
            wrapper.isExecuting = YES;
        }
    }
    return self;
}

- (void)executeJS {
    [webviewWrapper executeJS:[data generateJavascriptString:operationType] operation:self];
}

- (void)handleClickWithoutImpressionCase {
    isRequestInProgress = YES;
    [webviewWrapper executeJS:[data generateJavascriptForClickWithoutImpression] operation:self];
}

- (void)main {
    //this method gets called in a background thread. execute context code in webview inside a main thread.
    if (webviewWrapper != NULL && data != NULL && operationType != IMAdOperationTypeNone) {
        
        BOOL validOperation = NO;
        
        if (operationType == IMAdOperationTypeImpression && !data.isImpressionCountingFinished) {
            //impression counting valid case
            validOperation = YES;
            
        } else if(operationType == IMAdOperationTypeClick && !data.isClickCountingFinished) {
            //click counting case, first check if impression counting was completed
            if (data.isImpressionCountingFinished) {
                validOperation = YES;
            } else {
                //click counting being done but without a successful impression-counting
                //handle this case later..
                [self handleClickWithoutImpressionCase];
            }
        }
        
        if (validOperation) {
            isRequestInProgress = YES;
            //execute on main thread..
            [self executeJS];
        }
        
        while (isRequestInProgress) {
            sleep(1);
        }
    } else {
        IMLOGGING(@"invalid values provided for handling impression/click, please check object types:\n webview:%@\n, data:%@\n, operationType:%d",[webviewWrapper description],[data description],operationType);
    }
}

#pragma mark Delegate callback methods

- (void)sendSuccessCallback {
    isRequestInProgress = NO;
    webviewWrapper.isExecuting = NO;
    if (delegate && [delegate respondsToSelector:@selector(adOperationFinishedSuccessfully:)]) {
        [delegate adOperationFinishedSuccessfully:self];
    }
}
- (void)sendErrorCallback:(NSError *)error {
    isRequestInProgress = NO;
    webviewWrapper.isExecuting = NO;
    if (delegate && [delegate respondsToSelector:@selector(adOperation:failedWithError:)]) {
        [delegate adOperation:self failedWithError:error];
    }
}

#pragma mark UIWebview delegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    BOOL load = YES;
    NSURL *url = request.URL;
    if ([url isFileURL] ) {
        load = NO;
    }
    if ([[url absoluteString] isEqualToString:@"about:blank"]) {
        load = YES;
    }
    else if (![url.scheme isEqualToString:@"http"] && ![url.scheme isEqualToString:@"https"]) {
        load = NO;
    }
    return load;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    //IMLOGGING(@"webview started to load,operation=%d,ns=%@",operationType,data.ns);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (![webView isLoading]) {
        IMLOGGING(@"webview finished loading,operation=%d,ns=%@,bgTask=%lu",operationType,data.ns,(unsigned long)bgTask);
        //webview has finished loading..
        if (operationType == IMAdOperationTypeImpression) {
            //impression event recorded successfully.
            data.isImpressionCountingFinished = YES;
            
        } else if(operationType == IMAdOperationTypeClick) {
            //click recorded successfully..
            data.isClickCountingFinished = YES;
        }
        [self sendSuccessCallback];
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //IMLOGGING(@"failed to load with error:%@",[error description]);
    [self sendErrorCallback:error];
}


@end

@implementation IMWebViewWrapper

@synthesize webview,isExecuting,index;

- (id)init {
    self = [super init];
    if (self) {
        webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, 320, 50)];
        
    }
    return self;
}

- (void)executeJS:(NSString *)js {
    [webview loadHTMLString:js baseURL:nil];
}

- (void)executeJS:(NSString *)js operation:(IMAdOperation *)o {
    webview.delegate = o;
    isExecuting = YES;
    [self performSelectorOnMainThread:@selector(executeJS:) withObject:js waitUntilDone:NO];
}

@end

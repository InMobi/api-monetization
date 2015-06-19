//
//  ViewController.m
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import "ViewController.h"
#import "IMBanner.h"
#import "IMInterstitial.h"
#import "IMNative.h"
#import "IMResponseStubs.h"
#import "IMNativeQueue.h"

@interface ViewController () {
    IMNative *nativeAd;
    IMBanner *bannerAd;
    IMRequest *request;
}
@property(nonatomic,retain) IMNativeResponse *nativeAdResponse;
@property(nonatomic,copy) NSString *targetUrl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepare];
    request = [[IMRequest alloc] init];
    IMProperty *property = [[IMProperty alloc] initWithPropertyID:@"YOUR_PROPERTY_ID"];
    IMImpression *impression = [[IMImpression alloc] initWithSlot:[[IMSlot alloc] initWithAdSize:15 pos:nil]];
    IMDevice *device = [[IMDevice alloc] initWithCarrierIP:@"YOUR_CARRIER_IP"];
    request.property = property;
    request.device = device;
    request.impression = impression;
    
    nativeAd = [[IMNative alloc] init];
    
    [self refreshAd];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)prepare {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 250)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 58, 58)];
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = 4.0;
    [view addSubview:imgView];
    //[imgView setImage:[UIImage imageNamed:@"tictactoe_57.png"]];
    sponsored = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 60, 0, 60, 20)];
    sponsored.font = [UIFont fontWithName:@"Marker Felt" size:12];
    sponsored.backgroundColor = [UIColor clearColor];
    sponsored.textColor = [UIColor whiteColor];
    sponsored.textAlignment = NSTextAlignmentRight;
    sponsored.text = @"Sponsored";
    sponsored.alpha = 0;
    
    [view addSubview:sponsored];

    title = [[UILabel alloc] initWithFrame:CGRectMake(78, 10, 180, 20)];
    title.font = [UIFont fontWithName:@"Marker Felt" size:17];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    
    [view addSubview:title]; //title.text = @"This is a title";
    
    download = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width - 70, CGRectGetMaxY(imgView.frame) - 25 , 70 , 25 )];
    [download setBackgroundColor:title.backgroundColor];
    download.titleLabel.textAlignment = NSTextAlignmentRight;
    download.titleLabel.font =[UIFont fontWithName:@"Marker Felt" size:20];
    
    download.alpha = 0;
    [download addTarget:self action:@selector(startDownload) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:download];
    
    desc = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + 5, CGRectGetMaxY(download.frame) + 5, title.frame.size.width, 95)];
    desc.font = [UIFont fontWithName:@"Marker Felt" size:12]; desc.numberOfLines = 5;
    desc.textColor = title.textColor;
    desc.backgroundColor = title.backgroundColor;
    [view addSubview:desc];
    //[nativeAd handleClick:nil];
    
    UIButton *refresh = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [refresh addTarget:self action:@selector(refreshAd) forControlEvents:UIControlEventTouchUpInside];
    refresh.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 75, 370, 150, 30);
    [refresh setTitle:@"Refresh Native Ad" forState:UIControlStateNormal];
    [self.view addSubview:refresh];
}

- (void)refreshAd {
    [nativeAd loadRequest:request successBlock:^(NSArray *ads) {
        
        for (IMNativeResponse *ad in ads) {
            self.nativeAdResponse = ad;
            NSString *pubContentJson = [ad convertPubContentToJSON];
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:[pubContentJson dataUsingEncoding:NSASCIIStringEncoding] options:kNilOptions error:nil];
            if (jsonDictionary != nil) {
                title.text = [jsonDictionary objectForKey:@"title"];
                [download setTitle:[jsonDictionary objectForKey:@"cta"] forState:UIControlStateNormal];
                download.alpha = 1;
                self.targetUrl = [jsonDictionary objectForKey:@"landingURL"];
                sponsored.alpha = 1;
                NSDictionary *iconDictionary = [jsonDictionary objectForKey:@"icon"];
                NSString *iconUrl = [iconDictionary objectForKey:@"url"];
                [IMNativeQueue recordImpressionWithNamespace:ad.ns contextCode:ad.contextCode additionalParams:nil];
                if (iconUrl) {
                    imgView.image = nil;
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:iconUrl]];
                        if (data) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                imgView.image = [UIImage imageWithData:data];
                            });
                        }
                    });
                }
            }
        }
    } failureBlock:^(NSError *e) {
        NSLog(@"failed=%@",[e localizedDescription]);
    }];
}

- (void)startDownload {
    if (_targetUrl) {
        [IMNativeQueue recordClickWithNamespace:_nativeAdResponse.ns contextCode:_nativeAdResponse.contextCode additionalParams:nil];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_targetUrl]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

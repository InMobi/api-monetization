//
//  BannerView.h
//  Native ad sample
//
//  Created by Rishabh Chowdhary on 25/11/2014.
//  Copyright (c) 2014 Rishabh Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMRequest.h"

#define NO_FILL_ERROR 1
#define LOAD_IN_PROGRESS_ERROR 2
#define MANDATORY_PARAM_MISSING 3
#define INVALID_REQUEST_ERROR 4

@protocol BannerViewDelegate;
@interface BannerView : UIView

@property(nonatomic,retain) IMRequest *request;
@property(nonatomic,weak) id<BannerViewDelegate> delegate;
- (void)loadBannerAd;

@end


@protocol BannerViewDelegate <NSObject>

- (void)bannerViewFinishedLoading:(BannerView *)banner;
- (void)bannerView:(BannerView *)banner failedToLoadWithError:(NSError *)error;

@end
//
//  IMError.m
//  InMobiAPIMonetization-Sample
//
//  Created by Rishabh Chowdhary on 16/03/2015.
//  Copyright (c) 2015 InMobi. All rights reserved.
//

#import "IMError.h"

@implementation IMError

+ (instancetype)errorWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)dict {
    return [super errorWithDomain:domain code:code userInfo:dict];
}

@end

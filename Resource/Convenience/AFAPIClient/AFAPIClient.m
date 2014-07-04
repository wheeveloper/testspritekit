//
//  AFAPIClient.m
//  DateQ
//
//  Created by HoJun Lee on 2014. 1. 25..
//  Copyright (c) 2014년 Plan2white. All rights reserved.
//

#import "AFAPIClient.h"

@implementation AFAPIClient

+ (instancetype)sharedClient {
    
    static AFAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAPIClient alloc] init];
    });
    
    return _sharedClient;
    
}

@end

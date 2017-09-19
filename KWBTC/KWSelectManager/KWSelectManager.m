//
//  KWSelectManager.m
//  KWBTC
//
//  Created by Kevin on 2017/9/19.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import "KWSelectManager.h"

@implementation KWSelectManager

#pragma mark -- init
+ (KWSelectManager *)sharedController{
    static KWSelectManager *controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] init];
    });
    return controller;
    
}

- (instancetype)init {
    if (self = [super init]) {
    
    }
    return self;
}



@end

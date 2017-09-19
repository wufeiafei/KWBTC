//
//  KWSelectManager.h
//  KWBTC
//
//  Created by Kevin on 2017/9/19.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWSelectManager : NSObject

@property(nonatomic, assign) BOOL hasBFBTC;

@property(nonatomic, assign) BOOL hasHBBTC;

@property(nonatomic, assign) BOOL hasHBLTC;


+ (KWSelectManager *)sharedController;

@end

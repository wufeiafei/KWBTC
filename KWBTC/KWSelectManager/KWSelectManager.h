//
//  KWSelectManager.h
//  KWBTC
//
//  Created by Kevin on 2017/9/19.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWSelectManager : NSObject

@property(nonatomic, assign) BOOL hasRMB;

@property(nonatomic,strong) NSString *rateString;//汇率

+ (KWSelectManager *)sharedController;

@end

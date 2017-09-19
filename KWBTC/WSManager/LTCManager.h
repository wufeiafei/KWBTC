//
//  LTCManager.h
//  KWBTC
//
//  Created by Kevin on 2017/9/19.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DCPriceBlock)(NSString *price);

@interface LTCManager : NSObject

@property(nonatomic, strong) NSString *ltcPrice;

@property(nonatomic, copy) DCPriceBlock ltcBlock;

+ (LTCManager *)sharedController;


-(void)disConnect;

-(void)connect;


@end

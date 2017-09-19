//
//  BFWSManager.h
//  KWBTC
//
//  Created by Kevin on 2017/9/18.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DCPriceBlock)(NSString *price);

@interface BFWSManager : NSObject

@property(nonatomic, strong) NSString *btcPrice;

@property(nonatomic, copy) DCPriceBlock btcBlock;


+ (BFWSManager *)sharedController;


-(void)disConnect;

-(void)connect;

@end

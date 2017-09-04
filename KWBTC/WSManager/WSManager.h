//
//  WSManager.h
//  KWBTC
//
//  Created by Kevin on 2017/9/4.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^DCPriceBlock)(NSString *price);

@interface WSManager : NSObject

@property(nonatomic, strong) NSString *btcPrice;

@property(nonatomic, strong) NSString *ltcPrice;

@property(nonatomic, copy) DCPriceBlock btcBlock;

@property(nonatomic, copy) DCPriceBlock ltcBlock;


+ (WSManager *)sharedController;




@end

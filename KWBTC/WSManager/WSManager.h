//
//  WSManager.h
//  KWBTC
//
//  Created by Kevin on 2017/9/4.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^BTCPriceBlock)(NSString *price);

@interface WSManager : NSObject

@property(nonatomic, copy) BTCPriceBlock btcBlock;

+ (WSManager *)sharedController;




@end

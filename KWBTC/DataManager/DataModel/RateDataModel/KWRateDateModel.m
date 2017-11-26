//
//  KWRateDateModel.m
//  KWBTC
//
//  Created by Kevin on 2017/11/26.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import "KWRateDateModel.h"

@implementation KWRateDateModel


- (id)initWithParseDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        
        if ([dict objectForKey:@"bankno"]) {
            _banknm = [NSString stringWithFormat:@"%@",[dict objectForKey:@"bankno"]];
        }
        if ([dict objectForKey:@"banknm"]) {
            _banknm = [NSString stringWithFormat:@"%@",[dict objectForKey:@"banknm"]];
        }
        if ([dict objectForKey:@"se_sell"]) {
            _se_sell = [NSString stringWithFormat:@"%@",[dict objectForKey:@"se_sell"]];
            
        }
        if ([dict objectForKey:@"se_buy"]) {
            _se_buy = [NSString stringWithFormat:@"%@",[dict objectForKey:@"se_buy"]];;
            
        }
        if ([dict objectForKey:@"cn_sell"]) {
            _cn_sell = [NSString stringWithFormat:@"%@",[dict objectForKey:@"cn_sell"]];
        }
        if ([dict objectForKey:@"cn_buy"]) {
            _cn_buy = [NSString stringWithFormat:@"%@",[dict objectForKey:@"cn_buy"]];
        }
        
        if ([dict objectForKey:@"middle"]) {
            _middle = [NSString stringWithFormat:@"%@",[dict objectForKey:@"middle"]];
        }
        if ([dict objectForKey:@"upddate"]) {
            _upddate = [NSString stringWithFormat:@"%@",[dict objectForKey:@"upddate"]];
        }

    }
    return self;
}

@end

//
//  KWRateDateModel.h
//  KWBTC
//
//  Created by Kevin on 2017/11/26.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWRateDateModel : NSObject

@property (nonatomic, strong) NSString *bankno;

@property (nonatomic, strong) NSString *banknm;

@property (nonatomic, strong) NSString *se_sell;

@property (nonatomic, strong) NSString *se_buy;

@property (nonatomic, strong) NSString *cn_sell;

@property (nonatomic, strong) NSString *cn_buy;

@property (nonatomic, strong) NSString *middle;

@property (nonatomic, strong) NSString *upddate;

- (id)initWithParseDictionary:(NSDictionary *)dict;

@end

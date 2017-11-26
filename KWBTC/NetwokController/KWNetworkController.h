//
//  KWNetworkController.h
//
//
//  Created by Kevin on 2016/12/5.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWNetworkController : NSObject

+ (KWNetworkController *)sharedController;



#pragma mark --  Finance rate
- (void)getFinanceRateWithSuccess:(void (^)(id data))succ
                          Failure:(void (^)(id data))fail;




@end

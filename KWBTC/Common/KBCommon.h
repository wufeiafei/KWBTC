//
//  KBCommon.h
//
//
//  Created by Kevin on 2016/11/17.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KBCommon : NSObject

#pragma mark  --- json to data string
+ (NSString*)transferJsonToDataStringWithDic:(NSDictionary *)dic;


#pragma mark -- unzip gzip
+ (NSData *)uncompressZippedData:(NSData *)compressedData;

@end

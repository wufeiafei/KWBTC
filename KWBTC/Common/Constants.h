//
//  Constants.h
//  AfeiChat
//
//  Created by Kevin on 2016/11/15.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#import "KBCommon.h"
#import "KWRateDateModel.h"



/** DEBUG LOG **/
#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"<%@:(%d)>: %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif







#endif /* Constants_h */

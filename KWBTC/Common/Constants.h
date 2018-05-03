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



//bitfinex
//#define wsURL  @"wss://api.bitfinex.com/ws/2"
//#define wsURL  @"wss://api.bitfinex.com/ws"
//火币
//#define wsURL  @"wss://api.huobipro.com/ws"
//#define wsURL    @"wss://api.hadax.com/ws"
//h火币测试环境
#define  wsURL @"wss://api.huobi.br.com/ws"



#endif /* Constants_h */

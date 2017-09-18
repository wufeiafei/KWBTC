//
//  BFWSManager.m
//  KWBTC
//
//  Created by Kevin on 2017/9/18.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import "BFWSManager.h"
#import "JFRWebSocket.h"
#import "KBCommon.h"


@interface BFWSManager()<JFRWebSocketDelegate>
{
    JFRWebSocket *socket;
}

@end




@implementation BFWSManager

#pragma mark -- init
+ (BFWSManager *)sharedController{
    static BFWSManager *controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] init];
    });
    return controller;
    
}

- (instancetype)init {
    if (self = [super init]) {
        
        NSURL *url = [NSURL URLWithString:@"wss://api.bitfinex.com/ws/2"];
        socket = [[JFRWebSocket alloc] initWithURL:url
                                         protocols:@[@"chat",@"superchat"]];
        socket.delegate = self;
        
        [self connect];
        
    }
    return self;
}


#pragma mark -- conntect
-(void)connect
{
    
    [socket connect];
    
}


#pragma mark -- send
-(void)sendBTC
{
    
//    NSDictionary *dic = @{
//                          @"event": @"subscribe",
//                          @"channel": @"candles",
//                          @"key": @"trade:1m:tBTCUSD"
//                          };
    
   NSDictionary *dic = @{
                            @"event": @"subscribe",
                            @"channel": @"ticker",
                            @"symbol": @"tBTCUSD"
                        };
    
    NSString *string = [KBCommon transferJsonToDataStringWithDic:dic];
    
    [socket writeString:string];
    
}




#pragma mark -- pong
-(void)pongServerWithPongSting:(NSString*)pongString
{
    
    NSDictionary *dic = @{
                          @"pong":pongString?:@"",
                          
                          };
    
    NSString *string = [KBCommon transferJsonToDataStringWithDic:dic];
    
    [socket writeString:string];
    
}



#pragma mark -- delegate
-(void)websocketDidConnect:(JFRWebSocket*)socket {
    
    NSLog(@"websocket is connected");
    
    [self sendBTC];
    
}

-(void)websocketDidDisconnect:(JFRWebSocket*)socket error:(NSError*)error {
    NSLog(@"websocket is disconnected: %@",[error localizedDescription]);
    
    [self connect];
}

-(void)websocket:(JFRWebSocket*)socket didReceiveMessage:(NSString*)string {
    NSLog(@"got some text: %@",string);
    
    NSData *uData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    id data = [NSJSONSerialization JSONObjectWithData:uData
                                               options:0
                                                 error:&error];
    
    NSLog(@"data:%@",data);
    
    if ([data isKindOfClass:[NSArray class]]&&data) {
        NSArray *array =  data;
        
        if (array.count > 1) {
            id second = array[1];
            
            if ([second isKindOfClass:[NSArray class]]&& second) {
                NSArray *secondArray = second;
                if (secondArray.count) {
                    NSString *BTCPrice = secondArray[0];
                    _btcPrice = BTCPrice;
                    if (_btcBlock) {
                        _btcBlock(BTCPrice);
                    }
                    return;
                    
                }
            }
        }
    }
    
}


-(void)websocket:(JFRWebSocket*)socket didReceiveData:(NSData*)data {
    NSLog(@"got some binary data: %d",data.length);
    
    NSData *uData = [KBCommon uncompressZippedData:data];
    
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:uData
                                                        options:0
                                                          error:&error];
    NSLog(@"dic:%@",dic);
    
    if (dic[@"ping"]) {
        
        [self pongServerWithPongSting:dic[@"ping"]];
        
        return;
    }
    
    if ([dic[@"ch"] isEqualToString:@"market.btccny.kline.1min"]&&dic[@"tick"]) {
        
        NSDictionary *tickDic =dic[@"tick"];
        NSString *BTCPrice = tickDic[@"close"];
        _btcPrice = BTCPrice;
        if (_btcBlock) {
            _btcBlock(BTCPrice);
        }
        return;
    }
    
  
    
}



@end

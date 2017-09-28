//
//  LTCManager.m
//  KWBTC
//
//  Created by Kevin on 2017/9/19.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import "LTCManager.h"
#import "JFRWebSocket.h"


@interface LTCManager()<JFRWebSocketDelegate>
{
    JFRWebSocket *socket;
}

@end


@implementation LTCManager

#pragma mark -- init
+ (LTCManager *)sharedController{
    static LTCManager *controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] init];
    });
    return controller;
    
}

- (instancetype)init {
    if (self = [super init]) {
        
        NSURL *url = [NSURL URLWithString:@"wss://api.huobi.com/ws"];
        socket = [[JFRWebSocket alloc] initWithURL:url
                                         protocols:@[@"chat",@"superchat"]];
        socket.delegate = self;
        
        //[self connect];
        
        
    }
    return self;
}


#pragma mark -- conntect
-(void)connect
{
    
    [socket connect];
    
}

-(void)disConnect
{
    
    [socket disconnect];
}


#pragma mark -- send

-(void)sendLTC
{
    
    NSDictionary *dic = @{
                          @"sub": @"market.ltccny.kline.1min",
                          @"id": @"id1"
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
    
    [self sendLTC];
    
    
}

-(void)websocketDidDisconnect:(JFRWebSocket*)socket error:(NSError*)error {
    NSLog(@"websocket is disconnected: %@",[error localizedDescription]);
    
    if ([KWSelectManager sharedController].hasHBLTC) {
        
        [self connect];
    }
    
}

-(void)websocket:(JFRWebSocket*)socket didReceiveMessage:(NSString*)string {
    NSLog(@"got some text: %@",string);
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
    

    if ([dic[@"ch"] isEqualToString:@"market.ltccny.kline.1min"]&&dic[@"tick"]) {
        
        NSDictionary *tickDic =dic[@"tick"];
        NSString *LTCPrice = tickDic[@"close"];
        _ltcPrice = LTCPrice;
        if (_ltcBlock) {
            _ltcBlock(LTCPrice);
        }
        
        return;
    }
    
}


@end

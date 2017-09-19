//
//  AppDelegate.m
//  KWBTC
//
//  Created by Kevin on 2017/9/4.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import "AppDelegate.h"
#import "WSManager.h"
#import "BFWSManager.h"


@interface AppDelegate ()

@property (nonatomic ,strong) NSStatusItem *statusItem;     // 添加状态item属性

@property (nonatomic, strong) NSPopover *popover;   // 弹窗

@property (nonatomic, strong) NSMenu *menu;

@property (nonatomic, strong) NSMenuItem *bfItem;

@property (nonatomic, strong) NSMenuItem *hbItem;

@property (nonatomic, strong) NSMenuItem *hblItem;

@property (nonatomic, strong) NSMenuItem *exitItem;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    [self initSubView];
    

    [WSManager sharedController].btcBlock = ^(NSString *price) {
        
        [self refershPrice];
      
    };
    
    [LTCManager sharedController].ltcBlock = ^(NSString *price) {
        
        [self refershPrice];
        
    };
    
    
    [BFWSManager sharedController].btcBlock = ^(NSString *price) {
        
        [self refershPrice];
        
    };
    
    [self loadLocalData];
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


#pragma mark -- init
-(void)initSubView
{

    [self.menu addItem:self.bfItem];
    [self.menu addItem:self.hbItem];
    [self.menu addItem:self.hblItem];
    [self.menu addItem:self.exitItem];
    
    self.statusItem.menu = self.menu;
    
}

#pragma mark -- load loacl data
-(void)loadLocalData
{

    NSString *bBTCString = [[NSUserDefaults standardUserDefaults] objectForKey:k_BF_BTC];
    NSString *hBTCString = [[NSUserDefaults standardUserDefaults] objectForKey:k_HB_BTC];
    NSString *hLTCString = [[NSUserDefaults standardUserDefaults] objectForKey:k_HB_LTC];
    
    if (bBTCString.length) {
        
        self.bfItem.state = 1;
        [KWSelectManager sharedController].hasBFBTC = YES;
        [[BFWSManager sharedController] connect];
        
        
    }
    
    if (hBTCString.length) {
        
         self.hbItem.state = 1;
        [KWSelectManager sharedController].hasHBBTC = YES;
        [[WSManager sharedController] connect];
        
    }
    
    if (hLTCString.length) {
        
        self.hblItem.state = 1;
        [KWSelectManager sharedController].hasHBLTC = YES;
        [[LTCManager sharedController] connect];
    }
        
    
    if (!bBTCString.length && !hBTCString.length && !hLTCString.length) {
        self.bfItem.state = 1;
        [KWSelectManager sharedController].hasBFBTC = YES;
        [[BFWSManager sharedController] connect];
    }
    
    
}


#pragma mark -- action
-(void)bfItemPressed:(id)sender
{
    
    if (self.bfItem.state) {
        
        if (!self.hbItem.state&& !self.hblItem.state) {
            
            return;
        }
        self.bfItem.state = 0;
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:k_BF_BTC];
        
        [KWSelectManager sharedController].hasBFBTC = NO;
        [[BFWSManager sharedController] disConnect];
    }
    else
    {
        self.bfItem.state = 1;
        [[NSUserDefaults standardUserDefaults] setObject:@"BF_BTC" forKey:k_BF_BTC];
        
        [KWSelectManager sharedController].hasBFBTC = YES;
        [[BFWSManager sharedController] connect];
    
    }
    
   
    
}

-(void)hbItemPressed:(id)sender
{
    
    if (self.hbItem.state) {
        
        if (!self.bfItem.state&& !self.hblItem.state) {
            
            return;
        }
        self.hbItem.state = 0;
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:k_HB_BTC];
        [KWSelectManager sharedController].hasHBBTC = NO;
        
        [[WSManager sharedController] disConnect];
    }
    else
    {
        self.hbItem.state = 1;
        [[NSUserDefaults standardUserDefaults] setObject:@"HB_BTC" forKey:k_HB_BTC];
        [KWSelectManager sharedController].hasHBBTC = YES;
        [[WSManager sharedController] connect];
    }
    
  
    
}


-(void)hblItemPressed:(id)sender
{
    
    if (self.hblItem.state) {
        
        if (!self.bfItem.state && !self.hbItem.state) {
            
            return;
        }
        self.hblItem.state = 0;
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:k_HB_LTC];
        [KWSelectManager sharedController].hasHBLTC = NO;
        [[LTCManager sharedController] disConnect];
    }
    else
    {
        self.hblItem.state = 1;
        [[NSUserDefaults standardUserDefaults] setObject:@"HB_LTC" forKey:k_HB_LTC];
        [KWSelectManager sharedController].hasHBLTC = YES;
        [[LTCManager sharedController] connect];
    }
    
   
    
}



-(void)exitItemPressed:(id)sender
{

    [[NSApplication sharedApplication] terminate:self];

}

/*
#pragma mark -- stop
-(void)stopProcess
{

    [[WSManager sharedController] disConnect];
    [[BFWSManager sharedController] disConnect];
    [[LTCManager sharedController] disConnect];
}

#pragma mark -- start
-(void)startProcess
{


    if ([KWSelectManager sharedController].hasBFBTC) {
        
        [[BFWSManager sharedController] connect];
    
    }
    
    if ([KWSelectManager sharedController].hasHBBTC  ) {
        
        [[WSManager sharedController] connect];
    }
    
    if ([KWSelectManager sharedController].hasHBLTC) {
        [[LTCManager sharedController] connect];
    }
    
}
 */

#pragma mark -- refersh
-(void)refershPrice
{
    
    
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    
    if ([KWSelectManager sharedController].hasBFBTC) {
       
        NSString *btcPrice = [BFWSManager sharedController].btcPrice;
        
        NSString *bbtcTitle = [NSString stringWithFormat:@"B-$%@",btcPrice];
        [titleArray addObject:bbtcTitle];
        
    }
    
    if ([KWSelectManager sharedController].hasHBBTC) {
        
        NSString *btcPrice = [WSManager sharedController].btcPrice;
        NSString *hbtcTitle = [NSString stringWithFormat:@"B-￥%@",btcPrice];
        [titleArray addObject:hbtcTitle];
        
    }

    if ([KWSelectManager sharedController].hasHBLTC) {
        
        NSString *ltcPrice = [LTCManager sharedController].ltcPrice;
        NSString *ltcTitle = [NSString stringWithFormat:@"L-%@",ltcPrice];
        [titleArray addObject:ltcTitle];
    }
    
    if (titleArray.count == 1) {
        
        self.statusItem.title = titleArray[0];
        return;
    }
    
    if (titleArray.count > 1) {
        
        NSString *title = titleArray[0];
        for (int i = 1; i < titleArray.count; i++) {
            
            title = [NSString stringWithFormat:@"%@ | %@",title,titleArray[i]];
        }
        self.statusItem.title = title;
    }
    
    

}




#pragma mark -- getter
-(NSStatusItem*)statusItem
{
    if (!_statusItem) {
        
        _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        
    }
    return _statusItem;

}

-(NSMenu*)menu
{
    if (!_menu) {
        _menu = [[NSMenu alloc] init];
    }
    return _menu;
}

-(NSMenuItem*)bfItem
{
    if (!_bfItem) {
        _bfItem = [[NSMenuItem alloc] initWithTitle:@"BTC(bitfinex)"
                                             action:@selector(bfItemPressed:)
                                      keyEquivalent:@""];
        _bfItem.state = 0;
    }

    return _bfItem;
}


-(NSMenuItem*)hbItem
{
    if (!_hbItem) {
        _hbItem = [[NSMenuItem alloc] initWithTitle:@"BTC(火币)"
                                             action:@selector(hbItemPressed:)
                                      keyEquivalent:@""];
        _hbItem.state = 0;
    }
    
    return _hbItem;
}


-(NSMenuItem*)hblItem
{
    if (!_hblItem) {
        _hblItem = [[NSMenuItem alloc] initWithTitle:@"LTC(火币)"
                                              action:@selector(hblItemPressed:)
                                       keyEquivalent:@""];
        _hblItem.state = 0;
    }
    
    return _hblItem;
}

-(NSMenuItem*)exitItem
{
    if (!_exitItem) {
        _exitItem = [[NSMenuItem alloc] initWithTitle:@"退出"
                                               action:@selector(exitItemPressed:)
                                        keyEquivalent:@""];
        
    }
    return _exitItem;
}

@end

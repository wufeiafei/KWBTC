//
//  AppDelegate.m
//  KWBTC
//
//  Created by Kevin on 2017/9/4.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import "AppDelegate.h"
#import "BFWSManager.h"
#import "KWRateDateModel.h"


@interface AppDelegate ()

@property (nonatomic ,strong) NSStatusItem *statusItem;     // 添加状态item属性

@property (nonatomic, strong) NSPopover *popover;   // 弹窗

@property (nonatomic, strong) NSMenu *menu;

@property (nonatomic, strong) NSMenuItem *rmbItem;

@property (nonatomic, strong) NSMenuItem *exitItem;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    [self initSubView];
    

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


    [self.menu addItem:self.rmbItem];
    [self.menu addItem:self.exitItem];
    
    self.statusItem.menu = self.menu;
    
}

#pragma mark -- load loacl data
-(void)loadLocalData
{

    NSString *bRMBString = [[NSUserDefaults standardUserDefaults] objectForKey:k_RMB];
   
    
     [[BFWSManager sharedController] connect];
    
    if (bRMBString.length) {
        
        self.rmbItem.state = 1;
        [KWSelectManager sharedController].hasRMB = YES;
        
        [self requestFinanceRate];
    }
    
}

-(void)requestFinanceRate
{
    @weakify(self);
    void (^succ)(id data) = ^(id data)
    {
        @strongify(self);
        NSLog(@"data:%@",data);
        
        NSDictionary *resultDic = data[@"result"];
        KWRateDateModel *bocRateModel = [[KWRateDateModel alloc] initWithParseDictionary:[resultDic[@"USD"] objectForKey:@"BOC"]];
        [KWSelectManager sharedController].rateString = bocRateModel.middle;
        
        [self refershPrice];
    };
    
    void (^fail)(id data) = ^(id data)
    {
        
        NSLog(@" fail data:%@",data);
        
    };
    
    [[KWNetworkController sharedController] getFinanceRateWithSuccess:succ
                                                              Failure:fail];
    
}


#pragma mark -- action
-(void)rmbItemPressed:(id)sender
{
    
    if (self.rmbItem.state) {
        
        self.rmbItem.state = 0;
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:k_RMB];
        
        [KWSelectManager sharedController].hasRMB = NO;
        
    }
    else
    {
        self.rmbItem.state = 1;
        [[NSUserDefaults standardUserDefaults] setObject:@"BF_RMB" forKey:k_RMB];
        
        [KWSelectManager sharedController].hasRMB = YES;
        
        [self requestFinanceRate];
    
    }

}



-(void)exitItemPressed:(id)sender
{

    [[NSApplication sharedApplication] terminate:self];

}



#pragma mark -- refersh
-(void)refershPrice
{
    
    
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    
    NSString *btcPrice = [BFWSManager sharedController].btcPrice;
    CGFloat price = [btcPrice floatValue];
        
    NSString *bbtcTitle = [NSString stringWithFormat:@"B-$%.1f",price];
    [titleArray addObject:bbtcTitle];
        

    if ([KWSelectManager sharedController].hasRMB) {
        
        CGFloat rate = [[KWSelectManager sharedController].rateString floatValue];
        CGFloat rmb = price * rate/100;
        
        NSString *rmbTitle = [NSString stringWithFormat:@"￥%.1f",rmb];
        [titleArray addObject:rmbTitle];
        
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



-(NSMenuItem*)rmbItem
{
    if (!_rmbItem) {
        _rmbItem = [[NSMenuItem alloc] initWithTitle:@"RMB"
                                             action:@selector(rmbItemPressed:)
                                      keyEquivalent:@""];
        _rmbItem.state = 0;
    }
    
    return _rmbItem;
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

//
//  AppDelegate.m
//  KWBTC
//
//  Created by Kevin on 2017/9/4.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import "AppDelegate.h"
#import "WSManager.h"


@interface AppDelegate ()

@property (nonatomic ,strong) NSStatusItem *statusItem;     // 添加状态item属性
@property (nonatomic, strong) NSPopover *popover;   // 弹窗

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    NSMenu *menu = [[NSMenu alloc] init];
    NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"BTC - 火币网"
                                                  action:@selector(itemPressed:)
                                           keyEquivalent:@""];
    
    [menu addItem:item];
    
    
    self.statusItem.menu = menu;
    
   
    
    [WSManager sharedController].btcBlock = ^(NSString *price) {
        
         self.statusItem.title = [NSString stringWithFormat:@"BTC - %@",price];
        
    };
    
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



-(void)itemPressed:(id)sender
{


}

@end

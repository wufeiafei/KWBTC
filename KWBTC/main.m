//
//  main.m
//  KWBTC
//
//  Created by Kevin on 2017/9/4.
//  Copyright © 2017年 Kevin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    
    NSApplication *app = [NSApplication sharedApplication];
    id delegate = [[AppDelegate alloc] init];
    app.delegate = delegate;
    
    return NSApplicationMain(argc, argv);
    
    
    
}

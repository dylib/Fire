//
//  AppDelegate.m
//  Fire
//
//  Created by Ubiquitous on 5/23/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreImage/CoreImage.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSView *custom;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    [_window setOpaque:NO]; // YES by default
    // NSColor *semiTransparentBlue = [NSColor colorWithDeviceRed:0.0 green:0.0 blue:1.0 alpha:0.5];
    NSColor *semiTransparentBlack = [NSColor colorWithDeviceWhite:0.5 alpha:0.0];
    [_window setBackgroundColor:semiTransparentBlack];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

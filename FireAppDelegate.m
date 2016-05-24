/*
 File: FireAppDelegate.m
 Abstract: Standard app delegate
 Version: 1.1
 
 */

#import <CoreImage/CoreImage.h>
#import "FireAppDelegate.h"

@interface FireAppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSView *custom;

@end

@implementation FireAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    [_window setOpaque:NO]; // YES by default
    NSColor *semiTransparentBlack = [NSColor colorWithDeviceWhite:0.5 alpha:0.1];
    [_window setBackgroundColor:semiTransparentBlack];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}

-(BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    return NSTerminateNow;
}


@end

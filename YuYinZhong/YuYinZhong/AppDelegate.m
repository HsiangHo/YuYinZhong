//
//  AppDelegate.m
//  YuYinZhong
//
//  Created by Jovi on 9/13/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import "AppDelegate.h"
#import "HAFVoiceClockManager.h"
#import "ViewControllerManager.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate{
    NSStatusItem                    *_statusItem;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Yuyinzhong-menu"];
    NSMenuItem *menuItemAnnounce = [[NSMenuItem alloc] initWithTitle:@"Announce" action:@selector(announce_click:) keyEquivalent:@"a"];
    [menuItemAnnounce setTarget:self];
    NSMenuItem *menuItemAbout = [[NSMenuItem alloc] initWithTitle:@"About" action:@selector(about_click:) keyEquivalent:@""];
    [menuItemAbout setTarget:self];
    NSMenuItem *menuItemPreferences = [[NSMenuItem alloc] initWithTitle:@"Preferences" action:@selector(preference_click:) keyEquivalent:@""];
    [menuItemPreferences setTarget:self];
    NSMenuItem *menuItemRate = [[NSMenuItem alloc] initWithTitle:@"Rate In App Store" action:@selector(rate_click:) keyEquivalent:@""];
    [menuItemRate setTarget:self];
    NSMenuItem *menuItemTellFriends = [[NSMenuItem alloc] initWithTitle:@"Tell a friend" action:@selector(tellFriends_click:) keyEquivalent:@""];
    [menuItemTellFriends setTarget:self];
    NSMenuItem *menuItemHelp = [[NSMenuItem alloc] initWithTitle:@"Help" action:@selector(help_click:) keyEquivalent:@""];
    [menuItemHelp setTarget:self];
    NSMenuItem *menuItemQuit = [[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(quit_click:) keyEquivalent:@"q"];
    [menuItemQuit setTarget:self];
    
    [menu addItem:menuItemAnnounce];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:menuItemAbout];
    [menu addItem:menuItemPreferences];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:menuItemRate];
    [menu addItem:menuItemTellFriends];
    [menu addItem:menuItemHelp];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:menuItemQuit];
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:20];
    NSImage *image = [NSImage imageNamed:@"AppIcon"];
    [image setSize:NSMakeSize(18, 18)];
    [_statusItem setImage:image];
    [_statusItem setMenu:menu];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(IBAction)announce_click:(id)sender{
    [[HAFVoiceClockManager sharedManager] announceThisTimeUsingMandarin];
}

-(IBAction)about_click:(id)sender{
    [[ViewControllerManager instance] showAboutWindow];
}

-(IBAction)preference_click:(id)sender{
    [[ViewControllerManager instance] showPreferencesWindow];
}

-(IBAction)rate_click:(id)sender{
    
}

-(IBAction)tellFriends_click:(id)sender{
    
}

-(IBAction)help_click:(id)sender{
    
}

-(IBAction)quit_click:(id)sender{
    [NSApp terminate:nil];
}

@end

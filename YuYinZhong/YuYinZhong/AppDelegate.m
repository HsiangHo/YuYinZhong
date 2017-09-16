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
#import <XUIKit/XUIKit.h>
#import "define.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate{
    NSStatusItem                    *_statusItem;
    NSMenuItem                      *_menuItemAnnounce;
    NSMenuItem                      *_menuItemAbout;
    NSMenuItem                      *_menuItemPreferences;
    NSMenuItem                      *_menuItemRate;
    NSMenuItem                      *_menuItemTellFriends;
    NSMenuItem                      *_menuItemHelp;
    NSMenuItem                      *_menuItemQuit;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[XUISharingManager sharedManager] setShareItems:[[NSMutableArray alloc] initWithObjects:SHARE_CONTENT, nil]];
    
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Yuyinzhong-menu"];
    _menuItemAnnounce = [[NSMenuItem alloc] initWithTitle:@"" action:@selector(announce_click:) keyEquivalent:@"a"];
    [_menuItemAnnounce setTarget:self];
    _menuItemAbout = [[NSMenuItem alloc] initWithTitle:@"" action:@selector(about_click:) keyEquivalent:@""];
    [_menuItemAbout setTarget:self];
    _menuItemPreferences = [[NSMenuItem alloc] initWithTitle:@"" action:@selector(preference_click:) keyEquivalent:@","];
    [_menuItemPreferences setTarget:self];
    _menuItemRate = [[NSMenuItem alloc] initWithTitle:@"" action:@selector(rateApp_click:) keyEquivalent:@""];
    [_menuItemRate setTarget:self];
    _menuItemTellFriends = [[NSMenuItem alloc] initWithTitle:@"" action:@selector(tellFriends_click:) keyEquivalent:@""];
    [_menuItemTellFriends setSubmenu:[[XUISharingManager sharedManager] sharingMenu]];
    _menuItemHelp = [[NSMenuItem alloc] initWithTitle:@"" action:@selector(help_click:) keyEquivalent:@""];
    [_menuItemHelp setTarget:self];
    _menuItemQuit = [[NSMenuItem alloc] initWithTitle:@"" action:@selector(quit_click:) keyEquivalent:@"q"];
    [_menuItemQuit setTarget:self];
    
    [menu addItem:_menuItemAnnounce];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:_menuItemPreferences];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:_menuItemRate];
    [menu addItem:_menuItemTellFriends];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:_menuItemAbout];
    [menu addItem:_menuItemHelp];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:_menuItemQuit];
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:20];
    NSImage *image = [NSImage imageNamed:@"AppIcon"];
    [image setSize:NSMakeSize(18, 18)];
    [_statusItem setImage:image];
    [_statusItem setMenu:menu];
    
    [self __localizeString];
    [[XUILanguageManager sharedManager] addLanguageChangedBlock:^{
        [self __localizeString];
    }];
    [HAFVoiceClockManager sharedManager];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(void)__localizeString{
    [_menuItemAnnounce setTitle:XUILocalizedString(@"announce")];
    [_menuItemAbout setTitle:[NSString stringWithFormat:XUILocalizedString(@"about: %@"),APP_NAME]];
    [_menuItemPreferences setTitle:XUILocalizedString(@"preferences")];
    [_menuItemRate setTitle:XUILocalizedString(@"rate_in_App_Store")];
    [_menuItemTellFriends setTitle:XUILocalizedString(@"tell_a_friend")];
    [_menuItemHelp setTitle:XUILocalizedString(@"help")];
    [_menuItemQuit setTitle:XUILocalizedString(@"quit")];
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

-(IBAction)rateApp_click:(id)sender{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"macappstore://itunes.apple.com/app/id1286248614"]];
}

-(IBAction)help_click:(id)sender{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://hsiangho.github.io/"]];
}

-(IBAction)tellFriends_click:(id)sender{
    
}

-(IBAction)quit_click:(id)sender{
    [NSApp terminate:nil];
}

@end

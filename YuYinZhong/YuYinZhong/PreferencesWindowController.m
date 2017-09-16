//
//  PreferencesWindowController.m
//  YuYinZhong
//
//  Created by Jovi on 8/31/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import "PreferencesWindowController.h"
#import <XUIKit/XUIKit.h>
#import "HAFConfigureManager.h"

#define TITLE_COLOR             [NSColor colorWithHex:@"#333333" alpha:1.0]
#define TITLE_FONT              [NSFont fontWithName:@"Helvetica Neue" size:14]

@interface PreferencesWindowController ()

@end

@implementation PreferencesWindowController{
    XUIView                 *_mainView;
    XUICheckbox             *_cbLaunchAtLogin;
    XUICheckbox             *_cb24HourMode;
    XUILabel                *_lbLanguageString;
    XUIComboBox             *_cbLanguage;
    NSArray                 *_arrayLanguages;
    NSArray                 *_arrayLanguagesCode;
}

-(instancetype)init{
    if (self = [super initWithWindowNibName:@"PreferencesWindowController"]) {
        [self __initializedPreferencesWindowController];
    }
    return self;
}

-(void)__initializedPreferencesWindowController{
    _arrayLanguages = @[@"简体中文",@"繁體中文"];
    _arrayLanguagesCode = @[@"zh-Hans",@"zh-Hant"];
    __block PreferencesWindowController *selfBlock = self;
    _mainView = [[XUIView alloc] initWithFrame:NSMakeRect(0, 0, 200, 200)];
    _cbLaunchAtLogin = [[XUICheckbox alloc] initWithFrame:NSMakeRect(0, 0, 420, 30)];
    [_cbLaunchAtLogin setTitleColor:TITLE_COLOR];
    [_cbLaunchAtLogin setFont:TITLE_FONT];
    [_cbLaunchAtLogin setDetaY:3];
    [_cbLaunchAtLogin setTarget:self];
    [_cbLaunchAtLogin setAction:@selector(startup_click:)];
    [_cbLaunchAtLogin setState:[[HAFConfigureManager sharedManager] isStartup]];
    [_mainView addSubview:_cbLaunchAtLogin];
    
    _cb24HourMode = [[XUICheckbox alloc] initWithFrame:NSMakeRect(0, 0, 420, 30)];
    [_cb24HourMode setTitleColor:TITLE_COLOR];
    [_cb24HourMode setFont:TITLE_FONT];
    [_cb24HourMode setDetaY:3];
    [_cb24HourMode setTarget:self];
    [_cb24HourMode setAction:@selector(autoBlock_click:)];
    [_cb24HourMode setState:[[HAFConfigureManager sharedManager] isTwentyfourHour]];
    [_mainView addSubview:_cb24HourMode];
    
    _lbLanguageString = [[XUILabel alloc] initWithFrame:NSMakeRect(0, 0, 80, 23)];
    [_lbLanguageString setTextColor:TITLE_COLOR];
    [_lbLanguageString setFont:TITLE_FONT];
    [_mainView addSubview:_lbLanguageString];
    
    _cbLanguage = [[XUIComboBox alloc] initWithFrame:NSMakeRect(0, 0, 200, 26)];
    [_mainView addSubview:_cbLanguage];
    [_cbLanguage setTextColor:TITLE_COLOR];
    for(NSString *language in _arrayLanguages){
        [_cbLanguage addItemWithObjectValue:language];
    }
    NSString *currentLanguage = [[XUILanguageManager sharedManager] currentLanguage];
    NSUInteger indexLanguage = [_arrayLanguagesCode indexOfObject:currentLanguage];
    [_cbLanguage selectItemAtIndex:indexLanguage];
    [_cbLanguage setDelegate:(id<NSComboBoxDelegate>)self];
    [[XUILanguageManager sharedManager] addLanguageChangedBlock:^{
        [self __localizeString];
    }];
    
    [_mainView setLayoutSubviewBlock:^(NSView *view) {
        NSRect rctLanguageString = selfBlock->_lbLanguageString.frame;
        rctLanguageString.origin.x = 20;
        rctLanguageString.origin.y = 20;
        [selfBlock->_lbLanguageString setFrame:rctLanguageString];
        
        NSRect rctLanguage = selfBlock->_cbLanguage.frame;
        rctLanguage.origin.x = 100;
        rctLanguage.origin.y = NSMinY(rctLanguageString);
        [selfBlock->_cbLanguage setFrame:rctLanguage];

        NSRect rctAutoBlock = selfBlock->_cb24HourMode.frame;
        rctAutoBlock.origin.x = 20;
        rctAutoBlock.origin.y = NSMaxY(rctLanguageString) + 10;
        [selfBlock->_cb24HourMode setFrame:rctAutoBlock];
        
        NSRect rctLaunchAtLogin = selfBlock->_cbLaunchAtLogin.frame;
        rctLaunchAtLogin.origin.x = 20;
        rctLaunchAtLogin.origin.y = NSMaxY(rctAutoBlock);
        [selfBlock->_cbLaunchAtLogin setFrame:rctLaunchAtLogin];        
    }];
    
    [self __localizeString];
}

-(void)__localizeString{
    [_cbLaunchAtLogin setTitle:XUILocalizedString(@"launch_at_login")];
    [_cb24HourMode setTitle:XUILocalizedString(@"24_hour_mode")];
    [_lbLanguageString setText:[NSString stringWithFormat:@"%@:",XUILocalizedString(@"language")]];
    [self.window setTitle:XUILocalizedString(@"preferences")];
}

-(void)awakeFromNib{
    [self.window setBackgroundColor:[NSColor colorWithCalibratedRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.99]];
    [[self.window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
    [[self.window standardWindowButton:NSWindowZoomButton] setHidden:YES];
    [self.window setContentView:_mainView];
    [_mainView layoutSubviews];
}

-(IBAction)startup_click:(id)sender{
    [[HAFConfigureManager sharedManager] setStartup:NSOnState == [_cbLaunchAtLogin state]];
}

-(IBAction)autoBlock_click:(id)sender{
    [[HAFConfigureManager sharedManager] setTwentyfourHour:NSOnState == [_cb24HourMode state]];
}

-(void)showWindow:(id)sender{
    [self.window setLevel:NSStatusWindowLevel];
    [self.window center];
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
    [super showWindow:sender];
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification{
    NSString *languageCode = [_arrayLanguagesCode objectAtIndex: [_cbLanguage indexOfSelectedItem]];
    [[XUILanguageManager sharedManager] setLanguage:languageCode];
}

@end

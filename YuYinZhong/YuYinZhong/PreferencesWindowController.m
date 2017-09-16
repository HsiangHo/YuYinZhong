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
    
    XUILabel                *_lbAnnounceRuleString;
    NSArray                 *_arrayAnnounceRules;
    XUIComboBox             *_cbAnnounceRule;
    
    XUILabel                *_lbAnnounceTypeString;
    NSArray                 *_arrayAnnounceTypes;
    XUIComboBox             *_cbAnnounceType;
    
    XUILabel                *_lbLanguageString;
    XUIComboBox             *_cbLanguage;
    NSArray                 *_arrayLanguages;
    NSArray                 *_arrayLanguagesCode;
}

#pragma mark - Override methods

-(instancetype)init{
    if (self = [super initWithWindowNibName:@"PreferencesWindowController"]) {
        [self __initializedPreferencesWindowController];
    }
    return self;
}

-(void)awakeFromNib{
    [self.window setBackgroundColor:[NSColor colorWithCalibratedRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.99]];
    [[self.window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
    [[self.window standardWindowButton:NSWindowZoomButton] setHidden:YES];
    [self.window setContentView:_mainView];
    [_mainView layoutSubviews];
}

#pragma mark - Private methods

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
    
    _lbAnnounceRuleString = [[XUILabel alloc] initWithFrame:NSMakeRect(0, 0, 100, 23)];
    [_lbAnnounceRuleString setTextColor:TITLE_COLOR];
    [_lbAnnounceRuleString setFont:TITLE_FONT];
    [_mainView addSubview:_lbAnnounceRuleString];
    
    _cbAnnounceRule = [[XUIComboBox alloc] initWithFrame:NSMakeRect(0, 0, 200, 26)];
    [_mainView addSubview:_cbAnnounceRule];
    [_cbAnnounceRule setTextColor:TITLE_COLOR];
    [_cbAnnounceRule setDelegate:(id<NSComboBoxDelegate>)self];
    
    _lbAnnounceTypeString = [[XUILabel alloc] initWithFrame:NSMakeRect(0, 0, 100, 23)];
    [_lbAnnounceTypeString setTextColor:TITLE_COLOR];
    [_lbAnnounceTypeString setFont:TITLE_FONT];
    [_mainView addSubview:_lbAnnounceTypeString];
    
    _arrayAnnounceTypes = @[@"HH:mm",@"MM-dd HH:mm",@"WD HH:mm",@"MM-dd WD HH:mm",@"yyyy-MM-dd WD HH:mm"];
    _cbAnnounceType = [[XUIComboBox alloc] initWithFrame:NSMakeRect(0, 0, 200, 26)];
    [_mainView addSubview:_cbAnnounceType];
    [_cbAnnounceType setTextColor:TITLE_COLOR];
    for(NSString *style in _arrayAnnounceTypes){
        [_cbAnnounceType addItemWithObjectValue:style];
    }
    [_cbAnnounceType selectItemAtIndex:[[HAFConfigureManager sharedManager] announceType]];
    [_cbAnnounceType setDelegate:(id<NSComboBoxDelegate>)self];
    
    _cb24HourMode = [[XUICheckbox alloc] initWithFrame:NSMakeRect(0, 0, 420, 30)];
    [_cb24HourMode setTitleColor:TITLE_COLOR];
    [_cb24HourMode setFont:TITLE_FONT];
    [_cb24HourMode setDetaY:3];
    [_cb24HourMode setTarget:self];
    [_cb24HourMode setAction:@selector(twentyfourMode_click:)];
    [_cb24HourMode setState:[[HAFConfigureManager sharedManager] isTwentyfourHour]];
    [_mainView addSubview:_cb24HourMode];
    
    _lbLanguageString = [[XUILabel alloc] initWithFrame:NSMakeRect(0, 0, 100, 23)];
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
        rctLanguage.origin.x = 140;
        rctLanguage.origin.y = NSMinY(rctLanguageString);
        [selfBlock->_cbLanguage setFrame:rctLanguage];
        
        NSRect rctAnnounceTypeString = selfBlock->_lbAnnounceTypeString.frame;
        rctAnnounceTypeString.origin.x = 20;
        rctAnnounceTypeString.origin.y = NSMaxY(rctLanguageString) + 10;
        [selfBlock->_lbAnnounceTypeString setFrame:rctAnnounceTypeString];
        
        NSRect rctAnnounceType = selfBlock->_cbAnnounceType.frame;
        rctAnnounceType.origin.x = NSMinX(rctLanguage);
        rctAnnounceType.origin.y = NSMinY(rctAnnounceTypeString);
        [selfBlock->_cbAnnounceType setFrame:rctAnnounceType];
        
        NSRect rctAnnounceRuleString = selfBlock->_lbAnnounceRuleString.frame;
        rctAnnounceRuleString.origin.x = 20;
        rctAnnounceRuleString.origin.y = NSMaxY(rctAnnounceTypeString) + 10;
        [selfBlock->_lbAnnounceRuleString setFrame:rctAnnounceRuleString];
        
        NSRect rctAnnounceRule = selfBlock->_cbAnnounceRule.frame;
        rctAnnounceRule.origin.x = NSMinX(rctLanguage);;
        rctAnnounceRule.origin.y = NSMinY(rctAnnounceRuleString);
        [selfBlock->_cbAnnounceRule setFrame:rctAnnounceRule];

        NSRect rctAutoBlock = selfBlock->_cb24HourMode.frame;
        rctAutoBlock.origin.x = 20;
        rctAutoBlock.origin.y = NSMaxY(rctAnnounceRuleString) + 10;
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
    [_lbAnnounceRuleString setText:[NSString stringWithFormat:@"%@:",XUILocalizedString(@"announce_rule")]];
    [_lbAnnounceTypeString setText:[NSString stringWithFormat:@"%@:",XUILocalizedString(@"announce_type")]];
    [self.window setTitle:XUILocalizedString(@"preferences")];
    
    _arrayAnnounceRules = @[XUILocalizedString(@"announce_hourly"),XUILocalizedString(@"announce_half_hourly"),XUILocalizedString(@"announce_quarter_hourly"),XUILocalizedString(@"announce_by_hand")];
    [_cbAnnounceRule removeAllItems];
    for(NSString *rule in _arrayAnnounceRules){
        [_cbAnnounceRule addItemWithObjectValue:rule];
    }
    [_cbAnnounceRule selectItemAtIndex:[[HAFConfigureManager sharedManager] announceRule]];
}

-(void)__updateUI{
    [_cbLaunchAtLogin setState:[[HAFConfigureManager sharedManager] isStartup]];
    [_cb24HourMode setState:[[HAFConfigureManager sharedManager] isTwentyfourHour]];
    [_cbAnnounceType selectItemAtIndex:[[HAFConfigureManager sharedManager] announceType]];
    [_cbAnnounceRule selectItemAtIndex:[[HAFConfigureManager sharedManager] announceRule]];
}

#pragma mark - Public methods

-(IBAction)startup_click:(id)sender{
    [[HAFConfigureManager sharedManager] setStartup:NSOnState == [_cbLaunchAtLogin state]];
}

-(IBAction)twentyfourMode_click:(id)sender{
    [[HAFConfigureManager sharedManager] setTwentyfourHour:NSOnState == [_cb24HourMode state]];
}

-(void)showWindow:(id)sender{
    [self __updateUI];
    [self.window setLevel:NSStatusWindowLevel];
    [self.window center];
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
    [super showWindow:sender];
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification{
    if (nil == [notification object]) {
        return;
    }
    NSUInteger index = [[notification object] indexOfSelectedItem];
    if (-1 == index) {
        return;
    }
    if (_cbLanguage == [notification object]) {
        NSString *languageCode = [_arrayLanguagesCode objectAtIndex: [_cbLanguage indexOfSelectedItem]];
        [[XUILanguageManager sharedManager] setLanguage:languageCode];
    }else if(_cbAnnounceRule == [notification object]){
        [[HAFConfigureManager sharedManager] setAnnounceRule:index];
    }else if(_cbAnnounceType == [notification object]){
        [[HAFConfigureManager sharedManager] setAnnounceType:index];
    }
}

@end

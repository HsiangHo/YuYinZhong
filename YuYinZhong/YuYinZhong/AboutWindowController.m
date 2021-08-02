//
//  AboutWindowController.m
//  YuYinZhong
//
//  Created by Jovi on 5/11/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import "AboutWindowController.h"

@interface AboutWindowController ()

@end

@implementation AboutWindowController{
    IBOutlet    NSButton            *_btnIcon;
    IBOutlet    NSTextField         *_lbAppName;
    IBOutlet    NSTextField         *_lbVersion;
    IBOutlet    NSTextField         *_lbCopyright;
    IBOutlet    NSTextView          *_tvCredits;
    NSString                        *_strIconUrl;
}

-(instancetype)init{
    if (self = [super initWithWindowNibName:@"AboutWindowController"]) {
        [self __initializedAboutWindowController];
    }
    return self;
}

-(void)__initializedAboutWindowController{
    _strIconUrl = nil;
}

-(void)awakeFromNib{
    [[self.window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
    [[self.window standardWindowButton:NSWindowZoomButton] setHidden:YES];
}

-(void)showWindow:(id)sender{
    [self.window setLevel:NSStatusWindowLevel];
    [self.window center];
    [self __setupAboutInfo];
    [_tvCredits setTextColor:[NSColor textColor]];
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
    [super showWindow:sender];
}

-(void)__setupAboutInfo{
    NSDictionary *bundleDict = [[NSBundle mainBundle] infoDictionary];
    NSString *strAppName = [NSBundle mainBundle].localizedInfoDictionary[@"CFBundleDisplayName"];
    
    NSString *version = [bundleDict objectForKey:@"CFBundleVersion"];
    NSString *shortVersion = [bundleDict objectForKey:@"CFBundleShortVersionString"];
    NSString *strAppVersion = [NSString stringWithFormat:@"Version. %@ (%@)",shortVersion,version];
    
    NSString *strCopyRight = [bundleDict objectForKey:@"NSHumanReadableCopyright"];
    
//    _strIconUrl = NSLocalizedString(@"home_page_url", nil);
    _strIconUrl = @"https://hsiangho.github.io/";
    
    [_btnIcon setImage:[NSApp applicationIconImage]];
    [_btnIcon setFocusRingType:NSFocusRingTypeNone];
    [_lbAppName setStringValue:strAppName];
    [_lbVersion setStringValue:strAppVersion];
    [_lbCopyright setStringValue:strCopyRight];
    
    NSString *strCriditsFilePath = [[NSBundle mainBundle] pathForResource:@"Credits" ofType:@"rtf"];
    if (nil != strCriditsFilePath) {
        [_tvCredits readRTFDFromFile:strCriditsFilePath];
    }
}

-(IBAction)icon_click:(id)sender{
    if(nil != _strIconUrl && ![_strIconUrl isEqualToString:@""]){
        [self.window setLevel:NSNormalWindowLevel];
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:_strIconUrl]];
    }
}

@end

//
//  ViewControllerManager.m
//  YuYinZhong
//
//  Created by Jovi on 9/16/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import "ViewControllerManager.h"
#import "AboutWindowController.h"
#import "PreferencesWindowController.h"

static ViewControllerManager *instance;
@implementation ViewControllerManager{
    AboutWindowController                       *_aboutWindowController;
    PreferencesWindowController                 *_preferencesController;
}

+(ViewControllerManager *)instance{
    @synchronized (self) {
        if (nil == instance) {
            instance = [[ViewControllerManager alloc] init];
        }
        return instance;
    }
}

-(instancetype)init{
    if (self = [super init]) {
        [self __initializeViewControllerManager];
    }
    return self;
}

-(void)__initializeViewControllerManager{
    _aboutWindowController = [[AboutWindowController alloc] init];
    _preferencesController = [[PreferencesWindowController alloc] init];
}

-(void)showAboutWindow{
    [_aboutWindowController showWindow:nil];
}

-(void)showPreferencesWindow{
    [_preferencesController showWindow:nil];
}

@end

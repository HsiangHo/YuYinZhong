//
//  ViewControllerManager.h
//  YuYinZhong
//
//  Created by Jovi on 9/16/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AboutWindowController;
@class PreferencesWindowController;
@interface ViewControllerManager : NSObject

@property (nonatomic,strong,readonly)           AboutWindowController                           *aboutWindowController;
@property (nonatomic,strong,readonly)           PreferencesWindowController                     *preferencesController;

+(ViewControllerManager *)instance;
-(void)showAboutWindow;
-(void)showPreferencesWindow;

@end

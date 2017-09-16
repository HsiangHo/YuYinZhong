//
//  ViewControllerManager.h
//  YuYinZhong
//
//  Created by Jovi on 9/16/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllerManager : NSObject

+(ViewControllerManager *)instance;
-(void)showAboutWindow;
-(void)showPreferencesWindow;

@end

//
//  HAFVoiceClockManager.m
//  YuYinZhong
//
//  Created by Jovi on 9/14/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import "HAFVoiceClockManager.h"

static HAFVoiceClockManager *instance;
@implementation HAFVoiceClockManager

+(instancetype)sharedManager{
    @synchronized (self) {
        if (nil == instance) {
            instance = [[HAFVoiceClockManager alloc] init];
        }
        return instance;
    }
}

@end

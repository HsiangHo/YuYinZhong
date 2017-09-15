//
//  HAFVoiceClockManager.m
//  YuYinZhong
//
//  Created by Jovi on 9/14/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import "HAFVoiceClockManager.h"
#import "HAFAudioPlayer.h"
#import "HAFMandarinVoiceClock.h"

static HAFVoiceClockManager *instance;
@implementation HAFVoiceClockManager{
    HAFAudioPlayer                  *_player;
    HAFMandarinVoiceClock           *_mandarinClock;
    NSBundle                        *_bundleMandarin;
    HAF_Announce_Format_Type        _announceType;
    HAF_Announce_Rule               _announceRule;
    BOOL                            _twentyfourHour;
}

+(instancetype)sharedManager{
    @synchronized (self) {
        if (nil == instance) {
            instance = [[HAFVoiceClockManager alloc] init];
        }
        return instance;
    }
}

-(instancetype)init{
    if (self = [super init]) {
        [self __initializeHAFVoiceClockManager];
    }
    return self;
}

-(void)__initializeHAFVoiceClockManager{
    _player = [[HAFAudioPlayer alloc] init];
    _mandarinClock = [[HAFMandarinVoiceClock alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"vc-Zh-Hans" ofType:@"bundle"];
    _bundleMandarin = [NSBundle bundleWithPath:path];
}

-(void)announceThisTimeUsingMandarin{
    [_mandarinClock set24HourClock:_twentyfourHour];
    [_player startPlaying:[_mandarinClock announceThisTime:_announceType] withBundle:_bundleMandarin];
}

@end

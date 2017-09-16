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
#import "HAFConfigureManager.h"

static HAFVoiceClockManager *instance;
@implementation HAFVoiceClockManager{
    HAFAudioPlayer                  *_player;
    HAFMandarinVoiceClock           *_mandarinClock;
    NSBundle                        *_bundleMandarin;
    NSTimer                         *_taskDistributorTimer;
    NSTimer                         *_taskerTimer;
    NSDate                          *_nextFireDate;
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

-(void)announceThisTimeUsingMandarin{
    [_mandarinClock set24HourClock:[self isTwentyfourHour]];
    [_player startPlaying:[_mandarinClock announceThisTime:[self announceType]] withBundle:_bundleMandarin];
}

-(void)setAnnounceType:(HAF_Announce_Format_Type)announceType{
    [[HAFConfigureManager sharedManager] setAnnounceType:announceType];
}

-(HAF_Announce_Format_Type)announceType{
    return [[HAFConfigureManager sharedManager] announceType];
}

-(void)setAnnounceRule:(HAF_Announce_Rule)announceRule{
    [[HAFConfigureManager sharedManager] setAnnounceRule:announceRule];
}

-(HAF_Announce_Rule)announceRule{
    return [[HAFConfigureManager sharedManager] announceRule];
}

-(void)setTwentyfourHour:(BOOL)twentyfourHour{
    [[HAFConfigureManager sharedManager] setTwentyfourHour:twentyfourHour];
}

-(BOOL)isTwentyfourHour{
    return [[HAFConfigureManager sharedManager] isTwentyfourHour];
}

-(void)__initializeHAFVoiceClockManager{
    _player = [[HAFAudioPlayer alloc] init];
    _mandarinClock = [[HAFMandarinVoiceClock alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"vc-ZH-Han" ofType:@"bundle"];
    _bundleMandarin = [NSBundle bundleWithPath:path];
    _taskDistributorTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(__distributeAnnounceTask) userInfo:nil repeats:YES];
}

-(void)__distributeAnnounceTask{
    NSDate *date = [self __dateToNearest15Minutes];
    if(![date isEqualToDate:_nextFireDate]){
        _nextFireDate = date;
        _taskerTimer = [[NSTimer alloc] initWithFireDate:_nextFireDate interval:0 target:self selector:@selector(__taskAction) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:_taskerTimer forMode:NSDefaultRunLoopMode];
    }
}

-(void)__taskAction{
    BOOL bAnnounce = NO;
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:[NSDate date]];
    switch ([self announceRule]) {
        case eHAF_Announce_Hourly:
            bAnnounce = (0 == comps.minute);
            break;
            
        case eHAF_Announce_Half_Hourly:
            bAnnounce = (0 == comps.minute % 30);
            break;
            
        case eHAF_Announce_Quarter_Hourly:
            bAnnounce = (0 == comps.minute % 15);
            break;
            
        case eHAF_Announce_By_Hand:
        default:
            break;
    }
    if (bAnnounce) {
        [self announceThisTimeUsingMandarin];
    }
}

- (NSDate *)__dateToNearest15Minutes {
    unsigned unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit;
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date]];
    [comps setMinute:((([comps minute] - 8 ) / 15 ) * 15 ) + 15];
    [comps setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

@end

//
//  HAFVoiceClockManager.h
//  YuYinZhong
//
//  Created by Jovi on 9/14/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    eHAF_Announce_HH_mm,
    eHAF_Announce_MM_dd_HH_mm,
    eHAF_Announce_WEEK_HH_mm,
    eHAF_Announce_MM_dd_WEEK_HH_mm,
    eHAF_Announce_yyyy_MM_dd_WEEK_HH_mm,
}HAF_Announce_Format_Type;

@protocol HAFVoiceClockProtocol <NSObject>

-(void)set24HourClock:(BOOL)bValue;
-(NSArray *)announceThisTime:(HAF_Announce_Format_Type)type;

@end

@interface HAFVoiceClockManager : NSObject

+(instancetype)sharedManager;

@end

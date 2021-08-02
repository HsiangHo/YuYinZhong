//
//  HAFVoiceClockManager.h
//  YuYinZhong
//
//  Created by Jovi on 9/14/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    eHAF_Announce_Hourly,
    eHAF_Announce_Half_Hourly,
    eHAF_Announce_Quarter_Hourly,
    eHAF_Announce_By_Hand,
}HAF_Announce_Rule;

typedef enum : NSUInteger {
    eHAF_Announce_HH_mm,
    eHAF_Announce_MM_dd_HH_mm,
    eHAF_Announce_WEEK_HH_mm,
    eHAF_Announce_MM_dd_WEEK_HH_mm,
    eHAF_Announce_yyyy_MM_dd_WEEK_HH_mm,
}HAF_Announce_Format_Type;

@protocol HAFVoiceClockProtocol <NSObject>

-(void)set24HourClock:(BOOL)bValue;
-(NSArray<NSString *> *)announceThisTime:(HAF_Announce_Format_Type)type;

@end

@protocol HAFVoiceClockManagerDelegate <NSObject>

-(void)announcing;

@end

@interface HAFVoiceClockManager : NSObject

@property (nonatomic,assign)                                HAF_Announce_Rule           announceRule;
@property (nonatomic,assign)                                HAF_Announce_Format_Type    announceType;
@property (nonatomic,assign,getter=isTwentyfourHour)        BOOL                        twentyfourHour;
@property (nonatomic,weak)                                  id<HAFVoiceClockManagerDelegate>    delegate;

+(instancetype)sharedManager;
-(void)announceThisTimeUsingMandarin;
-(BOOL)isAnnouncing;

@end

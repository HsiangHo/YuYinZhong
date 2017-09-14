//
//  HAFMandarinVoiceClock.m
//  YuYinZhong
//
//  Created by Jovi on 9/15/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import "HAFMandarinVoiceClock.h"

@implementation HAFMandarinVoiceClock{
    BOOL        _is24HourClock;
}

#pragma mark - Public methods

-(void)set24HourClock:(BOOL)bValue{
    _is24HourClock = bValue;
}

-(NSArray *)announceThisTime:(HAF_Announce_Format_Type)type{
    NSMutableArray *rslt = [[NSMutableArray alloc] init];
    switch (type) {
        case eHAF_Announce_HH_mm:
            [rslt addObjectsFromArray:[self __currentTime]];
            break;
            
        case eHAF_Announce_WEEK_HH_mm:
            [rslt addObject:@"jintianshi"];
            [rslt addObjectsFromArray:[self __currentDayOfWeak]];
            [rslt addObjectsFromArray:[self __currentTime]];
            break;
            
        case eHAF_Announce_MM_dd_HH_mm:
            [rslt addObject:@"jintianshi"];
            [rslt addObjectsFromArray:[self __currentMonthAndDay]];
            [rslt addObjectsFromArray:[self __currentTime]];
            break;
            
        case eHAF_Announce_MM_dd_WEEK_HH_mm:
            [rslt addObject:@"jintianshi"];
            [rslt addObjectsFromArray:[self __currentMonthAndDay]];
            [rslt addObjectsFromArray:[self __currentDayOfWeak]];
            [rslt addObjectsFromArray:[self __currentTime]];
            break;
            
        case eHAF_Announce_yyyy_MM_dd_WEEK_HH_mm:
            [rslt addObject:@"jintianshi"];
            [rslt addObjectsFromArray:[self __currentYear]];
            [rslt addObjectsFromArray:[self __currentMonthAndDay]];
            [rslt addObjectsFromArray:[self __currentDayOfWeak]];
            [rslt addObjectsFromArray:[self __currentTime]];
            break;
            
        default:
            break;
    }
    return rslt;
}

#pragma mark - Private methods
-(NSArray *)__currentTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSArray *arrayDate = [strDate componentsSeparatedByString:@":"];
    
    NSMutableArray *arrayRslt = [[NSMutableArray alloc] init];
    int nHour = [[arrayDate objectAtIndex:0] intValue];
    int nMinute = [[arrayDate objectAtIndex:1] intValue];
    
    [arrayRslt addObject:@"xianzaishijian"];
    if (2 == nHour/10) {
        [arrayRslt addObject:@"2"];
        [arrayRslt addObject:@"10"];
    }else if (1 == nHour/10){
        [arrayRslt addObject:@"10"];
    }
    [arrayRslt addObject:[NSString stringWithFormat:@"%d",nHour%10]];
    [arrayRslt addObject:@"dian"];
    
    if (0 == nMinute) {
        [arrayRslt addObject:@"zheng"];
    }else{
        if (9 < nMinute) {
            if(19 < nMinute){
                [arrayRslt addObject:[NSString stringWithFormat:@"%d",nMinute/10]];
            }
            [arrayRslt addObject:@"10"];
        }else{
            [arrayRslt addObject:@"0"];
        }
        if (0 != nMinute%10) {
            [arrayRslt addObject:[NSString stringWithFormat:@"%d",nMinute%10]];
        }
        [arrayRslt addObject:@"fen"];
    }
    return [arrayRslt copy];
}

-(NSArray *)__currentDayOfWeak{
    NSDate*date = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                       fromDate:date];
    NSInteger weekday = comps.weekday;
    NSMutableArray *arrayRslt = [[NSMutableArray alloc] init];
    [arrayRslt addObject:@"xingqi"];
    if (1 == weekday) {
        [arrayRslt addObject:@"ri"];
    }else{
        [arrayRslt addObject:[NSString stringWithFormat:@"%d",(int)(weekday-1)]];
    }
    return [arrayRslt copy];
}

-(NSArray *)__currentMonthAndDay{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSArray *arrayDate = [strDate componentsSeparatedByString:@"-"];
    
    int nMonth = [[arrayDate objectAtIndex:0] intValue];
    int nDay = [[arrayDate objectAtIndex:1] intValue];
    NSMutableArray *arrayRslt = [[NSMutableArray alloc] init];
    if (nMonth > 9) {
        [arrayRslt addObject:@"10"];
    }
    [arrayRslt addObject:[NSString stringWithFormat:@"%d",nMonth%10]];
    [arrayRslt addObject:@"yue"];
    
    if (nDay > 9) {
        if (nDay/10 > 1) {
            [arrayRslt addObject:[NSString stringWithFormat:@"%d",nDay/10]];
        }
        [arrayRslt addObject:@"10"];
        if (0 != nDay%10) {
            [arrayRslt addObject:[NSString stringWithFormat:@"%d",nDay%10]];
        }
        [arrayRslt addObject:@"ri"];
    }
    return [arrayRslt copy];
}

-(NSArray *)__currentYear{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    int nYear = [strDate intValue];
    NSMutableArray *arrayRslt = [[NSMutableArray alloc] init];
    [arrayRslt addObject:[NSString stringWithFormat:@"%d",nYear/1000]];
    [arrayRslt addObject:[NSString stringWithFormat:@"%d",(nYear/100)%10]];
    [arrayRslt addObject:[NSString stringWithFormat:@"%d",(nYear/10)%100]];
    [arrayRslt addObject:[NSString stringWithFormat:@"%d",nYear%10]];
    [arrayRslt addObject:@"nian"];
    return [arrayRslt copy];
}

@end

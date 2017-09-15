//
//  HAFMandarinVoiceClock.m
//  YuYinZhong
//
//  Created by Jovi on 9/15/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import "HAFMandarinVoiceClock.h"

#define kJintianshijian             @"jintianshi"
#define kXianzaishijian             @"xianzaishijian"
#define k0                          @"0"
#define k1                          @"1"
#define k2                          @"2"
#define k3                          @"3"
#define k4                          @"4"
#define k5                          @"5"
#define k6                          @"6"
#define k7                          @"7"
#define k8                          @"8"
#define k9                          @"9"
#define k10                         @"10"
#define kDian                       @"dian"
#define kZheng                      @"zheng"
#define kFen                        @"fen"
#define kYue                        @"yue"
#define kRi                         @"ri"
#define kNian                       @"nian"
#define kXingqi                     @"xingqi"

@implementation HAFMandarinVoiceClock{
    BOOL        _is24HourClock;
}

#pragma mark - Public methods

-(void)set24HourClock:(BOOL)bValue{
    _is24HourClock = bValue;
}

-(NSArray<NSString *> *)announceThisTime:(HAF_Announce_Format_Type)type{
    NSMutableArray *rslt = [[NSMutableArray alloc] init];
    switch (type) {
        case eHAF_Announce_HH_mm:
            [rslt addObjectsFromArray:[self __currentTime]];
            break;
            
        case eHAF_Announce_WEEK_HH_mm:
            [rslt addObject:kJintianshijian];
            [rslt addObjectsFromArray:[self __currentDayOfWeak]];
            [rslt addObjectsFromArray:[self __currentTime]];
            break;
            
        case eHAF_Announce_MM_dd_HH_mm:
            [rslt addObject:kJintianshijian];
            [rslt addObjectsFromArray:[self __currentMonthAndDay]];
            [rslt addObjectsFromArray:[self __currentTime]];
            break;
            
        case eHAF_Announce_MM_dd_WEEK_HH_mm:
            [rslt addObject:kJintianshijian];
            [rslt addObjectsFromArray:[self __currentMonthAndDay]];
            [rslt addObjectsFromArray:[self __currentDayOfWeak]];
            [rslt addObjectsFromArray:[self __currentTime]];
            break;
            
        case eHAF_Announce_yyyy_MM_dd_WEEK_HH_mm:
            [rslt addObject:kJintianshijian];
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
    
    [arrayRslt addObject:kXianzaishijian];
    if (2 == nHour/10) {
        [arrayRslt addObject:k2];
        [arrayRslt addObject:k10];
    }else if (1 == nHour/10){
        [arrayRslt addObject:k10];
    }
    if (0 != nHour%10){
         [arrayRslt addObject:[NSString stringWithFormat:@"%d",nHour%10]];
    }
    [arrayRslt addObject:kDian];
    
    if (0 == nMinute) {
        [arrayRslt addObject:kZheng];
    }else{
        if (9 < nMinute) {
            if(19 < nMinute){
                [arrayRslt addObject:[NSString stringWithFormat:@"%d",nMinute/10]];
            }
            [arrayRslt addObject:k10];
        }else{
            [arrayRslt addObject:k0];
        }
        if (0 != nMinute%10) {
            [arrayRslt addObject:[NSString stringWithFormat:@"%d",nMinute%10]];
        }
        [arrayRslt addObject:kFen];
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
    [arrayRslt addObject:kXingqi];
    if (1 == weekday) {
        [arrayRslt addObject:kRi];
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
        [arrayRslt addObject:k10];
    }
    [arrayRslt addObject:[NSString stringWithFormat:@"%d",nMonth%10]];
    [arrayRslt addObject:kYue];
    
    if (nDay > 9) {
        if (nDay/10 > 1) {
            [arrayRslt addObject:[NSString stringWithFormat:@"%d",nDay/10]];
        }
        [arrayRslt addObject:k10];
        if (0 != nDay%10) {
            [arrayRslt addObject:[NSString stringWithFormat:@"%d",nDay%10]];
        }
        [arrayRslt addObject:kRi];
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
    [arrayRslt addObject:kNian];
    return [arrayRslt copy];
}

@end

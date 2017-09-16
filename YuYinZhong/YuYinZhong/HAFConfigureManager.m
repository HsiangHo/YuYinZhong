//
//  HAFConfigureManager.m
//  YuYinZhong
//
//  Created by Jovi on 8/31/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import "HAFConfigureManager.h"
#import <ServiceManagement/ServiceManagement.h>

#define helperAppBundleIdentifier @"com.HyperartFlow.YuYinZhong.LaunchAtLoginHelper"
#define terminateNotification @"TerminateHelper"

#define kAnnounceRule                   @"announceRule"
#define kAnnounceType                   @"announceType"
#define kIsTwentyfourHour               @"isTwentyfourHour"

static HAFConfigureManager *instance;
@implementation HAFConfigureManager

+(instancetype)sharedManager{
    @synchronized (self) {
        if (nil == instance) {
            instance = [[HAFConfigureManager alloc] init];
        }
        return instance;
    }
}

-(BOOL)isStartup{
    NSArray *jobs = (__bridge NSArray *)SMCopyAllJobDictionaries(kSMDomainUserLaunchd);
    if (jobs == nil) {
        return NO;
    }
    
    if ([jobs count] == 0) {
        CFRelease((__bridge CFArrayRef)jobs);
        return NO;
    }
    
    BOOL onDemand = NO;
    for (NSDictionary *job in jobs) {
        if ([helperAppBundleIdentifier isEqualToString:[job objectForKey:@"Label"]]) {
            onDemand = [[job objectForKey:@"OnDemand"] boolValue];
            break;
        }
    }
    
    CFRelease((__bridge CFArrayRef)jobs);
    return onDemand;
}

-(void)setStartup:(BOOL)bValue{
    SMLoginItemSetEnabled ((__bridge CFStringRef)helperAppBundleIdentifier, bValue);
}

-(void)setAnnounceRule:(NSUInteger)announceRule{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithUnsignedInteger:announceRule] forKey:kAnnounceRule];
}

-(NSUInteger)announceRule{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kAnnounceRule] unsignedIntegerValue];
}

-(void)setAnnounceType:(NSUInteger)announceType{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithUnsignedInteger:announceType] forKey:kAnnounceType];
}

-(NSUInteger)announceType{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kAnnounceType] unsignedIntegerValue];
}

-(void)setTwentyfourHour:(BOOL)twentyfourHour{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:twentyfourHour] forKey:kIsTwentyfourHour];
}

-(BOOL)isTwentyfourHour{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kIsTwentyfourHour] boolValue];
}

@end

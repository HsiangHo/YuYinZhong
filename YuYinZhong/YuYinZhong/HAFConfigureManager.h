//
//  HAFConfigureManager.h
//  YuYinZhong
//
//  Created by Jovi on 8/31/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAFConfigureManager : NSObject

@property (nonatomic,assign)                                NSUInteger                  announceRule;
@property (nonatomic,assign)                                NSUInteger                  announceType;
@property (nonatomic,assign,getter=isTwentyfourHour)        BOOL                        twentyfourHour;
@property (nonatomic,assign)                                float                  volume;

+(instancetype)sharedManager;
-(BOOL)isStartup;
-(void)setStartup:(BOOL)bValue;

@end

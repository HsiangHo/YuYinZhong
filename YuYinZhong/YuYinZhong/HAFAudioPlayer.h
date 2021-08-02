//
//  HAFAudioPlayer.h
//  YuYinZhong
//
//  Created by Jovi on 9/14/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAFAudioPlayer : NSObject

@property (nonatomic,assign)                                float                  volume;

-(void)startPlaying:(NSArray *)arrayTracks withBundle:(NSBundle *)bundle;
-(void)stopPlaying;
-(BOOL)isPlaying;

@end

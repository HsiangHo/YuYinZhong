//
//  HAFAudioPlayer.h
//  YuYinZhong
//
//  Created by Jovi on 9/14/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAFAudioPlayer : NSObject

-(void)startPlaying:(NSArray *)arrayTracks;
-(void)stopPlaying;
-(BOOL)isPlaying;

@end

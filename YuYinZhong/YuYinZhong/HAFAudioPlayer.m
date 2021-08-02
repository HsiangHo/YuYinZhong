//
//  HAFAudioPlayer.m
//  YuYinZhong
//
//  Created by Jovi on 9/14/17.
//  Copyright © 2017 Jovi. All rights reserved.
//

#import "HAFAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@implementation HAFAudioPlayer{
    AVAudioPlayer           *_audioPlayer;
    NSArray                 *_arrayOfTracks;
    NSUInteger              _currentTrackNumber;
    NSBundle                *_bundle;
    float                   _volume;
}

-(void)startPlaying:(NSArray *)arrayTracks withBundle:(NSBundle *)bundle{
    if (_audioPlayer) {
        [_audioPlayer stop];
        _audioPlayer = nil;
    }
    _bundle = bundle;
    _currentTrackNumber = 0;
    _arrayOfTracks = arrayTracks;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[self __bundle] pathForResource:[[NSString alloc] initWithString:[_arrayOfTracks objectAtIndex:_currentTrackNumber]] ofType:@"wav"]] error:NULL];
    _audioPlayer.delegate = (id<AVAudioPlayerDelegate>)self;
    _audioPlayer.volume = _volume;
    [_audioPlayer play];
}

- (void)stopPlaying{
    [_audioPlayer stop];
}

-(BOOL)isPlaying{
    BOOL bRtn = NO;
    if (nil != _audioPlayer) {
        bRtn = [_audioPlayer isPlaying];
    }
    return bRtn;
}

-(NSBundle *)__bundle{
    if (nil == _bundle) {
        return [NSBundle mainBundle];
    }
    return _bundle;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (flag) {
        if (_currentTrackNumber < [_arrayOfTracks count] - 1) {
            _currentTrackNumber ++;
            if (nil == _audioPlayer) {
                [_audioPlayer stop];
                _audioPlayer = nil;
            }
            _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[self __bundle] pathForResource:[[NSString alloc] initWithString:[_arrayOfTracks objectAtIndex:_currentTrackNumber]] ofType:@"wav"]] error:NULL];
            _audioPlayer.delegate = (id<AVAudioPlayerDelegate>)self;
            _audioPlayer.volume = _volume;
            [_audioPlayer play];
        }
    }
}

@end

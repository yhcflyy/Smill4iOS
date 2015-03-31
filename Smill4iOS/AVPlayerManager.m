//
//  AVPlayerManager.m
//  Smill4iOS
//
//  Created by yaohongchao on 3/31/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import "AVPlayerManager.h"

@implementation AVPlayerManager

+(AVPlayerManager*)GetInstance{
    static dispatch_once_t pred = 0;
    __strong static AVPlayerManager *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[AVPlayerManager alloc] init]; // or some other init method
    });
    return _sharedObject;
}

-(AVPlayerLayer*)getAVPlayerLayer:(NSString*)videoURL{
    NSString *urlStr=videoURL;
    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    self.playerItem=[AVPlayerItem playerItemWithURL:url];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    //[self.player replaceCurrentItemWithPlayerItem:playerItem];
    //[self.player pause];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.videoGravity = AVLayerVideoGravityResize;
    return playerLayer;
    
}
-(AVPlayer*)getAVPlayer{
    return self.player;
}

-(void)play{
    [self.player play];
}
-(void)pause{
    [self.player pause];
}

-(AVPlayerItem *)getPlayItem{
    return self.playerItem;
}

@end

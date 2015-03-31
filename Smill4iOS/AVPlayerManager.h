//
//  AVPlayerManager.h
//  Smill4iOS
//
//  Created by yaohongchao on 3/31/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AVPlayerManager : NSObject
@property(strong,nonatomic) AVPlayer *player;
@property(strong,nonatomic) AVPlayerItem* playerItem;
+(AVPlayerManager*)GetInstance;
-(AVPlayerLayer*)getAVPlayerLayer:(NSString*)videoURL;
-(AVPlayer*)getAVPlayer;
-(void)play;
-(void)pause;
-(AVPlayerItem *)getPlayItem;
@end

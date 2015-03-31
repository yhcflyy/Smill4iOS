//
//  VideoViewCell.h
//  Smill4iOS
//
//  Created by yaohongchao on 3/28/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSCollectionViewCell.h"
#import "VideoInfo.h"
#import "Config.h"
#import <AVFoundation/AVFoundation.h>
#import "AVPlayerManager.h"

@interface VideoViewCell : PSCollectionViewCell

@property(strong,nonatomic) UIImageView *headImageView;
@property(strong,nonatomic) UILabel *publishDateLabel;
@property(strong,nonatomic) UILabel *userNameLabel;
@property(strong,nonatomic) UIImageView *videoView;
@property(strong,nonatomic) UILabel *contentLabel;
//@property(assign,nonatomic) CGFloat imageHeight;
@property(strong,nonatomic) UIButton *playBtn;
@property(strong,nonatomic) UIProgressView *progressView;
@property(assign,nonatomic) int playingVideoID;
@end

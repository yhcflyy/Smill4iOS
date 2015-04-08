//
//  VoiceViewCell.h
//  Smill4iOS
//
//  Created by yaohongchao on 4/8/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import "PSCollectionViewCell.h"
#import "VoiceInfo.h"
#import "Config.h"

@interface VoiceViewCell : PSCollectionViewCell
@property(strong,nonatomic) UIImageView *headImageView;
@property(strong,nonatomic) UILabel *publishDateLabel;
@property(strong,nonatomic) UILabel *userNameLabel;
@property(strong,nonatomic) UIImageView *contentImageView;
@property(strong,nonatomic) UILabel *contentLabel;
@property(assign,nonatomic) CGFloat imageHeight;
@end

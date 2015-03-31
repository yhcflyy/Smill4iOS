//
//  BaseViewCell.h
//  Smill4iOS
//
//  Created by flyy on 15/2/26.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCollectionViewCell.h"
#import "InfoModel.h"
#import "Config.h"

@interface PicViewCell : PSCollectionViewCell

@property(strong,nonatomic) UIImageView *headImageView;
@property(strong,nonatomic) UILabel *publishDateLabel;
@property(strong,nonatomic) UILabel *userNameLabel;
@property(strong,nonatomic) UIImageView *contentImageView;
@property(strong,nonatomic) UILabel *contentLabel;
@property(assign,nonatomic) CGFloat imageHeight;

@end

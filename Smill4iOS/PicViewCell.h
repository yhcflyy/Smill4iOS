//
//  BaseViewCell.h
//  Smill4iOS
//
//  Created by flyy on 15/2/26.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCollectionViewCell.h"
#import "THProgressView.h"

@interface PicViewCell : PSCollectionViewCell

@property(strong,nonatomic) UIImageView *contentImageView;
@property(strong,nonatomic) UILabel *titleLabel;
@property(strong,nonatomic) THProgressView *progressView;
@property(assign,nonatomic) int height;
@property(assign,nonatomic) int width;

@end

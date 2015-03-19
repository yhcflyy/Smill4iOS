//
//  BaseViewCell.h
//  Smill4iOS
//
//  Created by yaohongchao on 3/19/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCollectionViewCell.h"
#import "THProgressView.h"
#import "BaseModel.h"
#import "Config.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+ProgressView.h"


@interface BaseViewCell : PSCollectionViewCell

@property(strong,nonatomic) UIImageView *headImageView;
@property(strong,nonatomic) UILabel *publishDateLabel;
@property(strong,nonatomic) UILabel *userNameLabel;
@property(strong,nonatomic) UILabel *contentLabel;

@end

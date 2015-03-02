//
//  BaseViewCell.h
//  Smill4iOS
//
//  Created by flyy on 15/2/26.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicViewCell : UITableViewCell

@property(strong,nonatomic) UIImageView *contentImageView;
@property(strong,nonatomic) UILabel *titleLabel;
@property(assign,nonatomic) int height;

@end

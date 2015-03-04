//
//  BaseViewCell.m
//  Smill4iOS
//
//  Created by flyy on 15/2/26.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "PicViewCell.h"

@implementation PicViewCell



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame];
        [self initContent];
    }
    
    return self;
}
-(void)initContent
{
    self.contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width, self.frame.size.height)];
    self.contentImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:self.contentImageView];
    
//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
//    [self.contentView addSubview:self.titleLabel];
}

-(NSString *)reuseIdentifier
{
    return @"reusedIdentifier";
}

@end

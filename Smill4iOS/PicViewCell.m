//
//  BaseViewCell.m
//  Smill4iOS
//
//  Created by flyy on 15/2/26.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "PicViewCell.h"

@implementation PicViewCell

- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width - 20, 400)];
    [self.contentView addSubview:self.contentImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    [self.contentView addSubview:self.titleLabel];
}

-(NSString *)reuseIdentifier
{
    return @"reusedIdentifier";
}

@end

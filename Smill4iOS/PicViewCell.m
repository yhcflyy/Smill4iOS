//
//  BaseViewCell.m
//  Smill4iOS
//
//  Created by flyy on 15/2/26.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "PicViewCell.h"
#import "InfoModel.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+ProgressView.h"

#define MARGIN 8.0

@implementation PicViewCell



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.contentImageView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:self.contentImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.titleLabel];
    
    }
    
    return self;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.contentImageView.image = nil;
    self.titleLabel.text = nil;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    InfoModel *infoModel=self.object;
    
    CGFloat width = self.frame.size.width - MARGIN * 2;
    CGFloat top = MARGIN;
    CGFloat left = MARGIN;
    //基本设置
    UIFont *textFont = [UIFont systemFontOfSize:17.0f];
    self.titleLabel.font = textFont;
    //折行
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //必须写，否则只显示一行
    [self.titleLabel setNumberOfLines:0];
    //[self addSubview:self.titleLabel];
    //最大尺寸
    // MAXFLOAT 为可设置的最大高度
    CGSize size = CGSizeMake(300, MAXFLOAT);
    //获取当前那本属性
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName, nil];
    //实际尺寸
    CGSize actualSize = [infoModel.context boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.titleLabel.frame = CGRectMake(0, 0, actualSize.width,actualSize.height);
   
    self.height=actualSize.height;
    self.width=actualSize.width;
    
    // Image
    CGFloat objectWidth, objectHeight;
    if (infoModel.picWidth == 0) {
        objectWidth = 200.0f;
    } else {
        objectWidth = infoModel.picWidth;
    }
    if (infoModel.picHeight == 0) {
        objectHeight = 200.0f;
    } else {
        objectHeight = infoModel.picHeight;
    }
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    self.contentImageView.frame = CGRectMake(left, top + actualSize.height, width, scaledHeight);
    self.height += scaledHeight;
    
  
  
}

- (void)collectionView:(PSCollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index {
    [super collectionView:collectionView fillCellWithObject:object atIndex:index];
    
   
    
    InfoModel *infoModel=object;
    NSURL *showPicURL = [NSURL URLWithString:infoModel.imageUrl];
    self.titleLabel.text = infoModel.context;
    [self.contentImageView sd_setImageWithPreviousCachedImageWithURL:showPicURL
                                                  andPlaceholderImage:nil
                                                              options:0
                                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         //progressView=nil;
         if (image) {
             self.contentImageView.image = image;
         }
     }];

}

@end

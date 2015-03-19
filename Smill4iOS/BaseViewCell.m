//
//  BaseViewCell.m
//  Smill4iOS
//
//  Created by yaohongchao on 3/19/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import "BaseViewCell.h"

@implementation BaseViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headImageView=[[UIImageView alloc]initWithFrame:CGRectZero];
        self.headImageView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:self.headImageView];
        
        self.userNameLabel=[[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.userNameLabel];
        
        self.publishDateLabel=[[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.publishDateLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.contentLabel];
        
    }
    
    return self;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    self.headImageView.image=nil;
    self.userNameLabel.text=nil;
    self.publishDateLabel.text=nil;
    self.contentLabel.text = nil;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    BaseModel *infoModel=self.object;
    
    CGFloat width = self.frame.size.width - MARGIN * 2;
    
    //个人资料
    self.headImageView.frame=CGRectMake(MARGIN, MARGIN, HEAD_WIDTH, HEAD_WIDTH);
    self.userNameLabel.frame=CGRectMake(MARGIN+HEAD_WIDTH + 5, MARGIN, width - 100, HEAD_WIDTH*0.5);
    self.userNameLabel.font=[UIFont systemFontOfSize:13];
    self.publishDateLabel.frame=CGRectMake(MARGIN+HEAD_WIDTH + 5, MARGIN + HEAD_WIDTH*0.5, width - 100, HEAD_WIDTH*0.5);
    self.publishDateLabel.font=[UIFont systemFontOfSize:9];
    
    //内容
    UIFont *textFont = [UIFont systemFontOfSize:17.0f];
    self.contentLabel.font = textFont;
    
    //折行
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //必须写，否则只显示一行
    [self.contentLabel setNumberOfLines:0];
    //最大尺寸
    // MAXFLOAT 为可设置的最大高度
    CGSize size = CGSizeMake(300, MAXFLOAT);
    //获取当前那本属性
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName, nil];
    //实际尺寸
    CGSize actualSize = [infoModel.context boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.contentLabel.frame = CGRectMake(MARGIN, HEAD_WIDTH + 2*MARGIN -5, width ,actualSize.height);

}

- (void)collectionView:(PSCollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index {
    [super collectionView:collectionView fillCellWithObject:object atIndex:index];
    BaseModel *infoModel=object;
    self.contentLabel.text = infoModel.context;
    self.userNameLabel.text=infoModel.publisher;
    self.publishDateLabel.text=infoModel.publishDate;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:infoModel.headImageUrl]];
//    [self.headImageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:infoModel.headImageUrl]
//                                              andPlaceholderImage:nil
//                                                          options:0
//                                                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                                                         } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                                             if (image) {
//                                                                 self.headImageView.image = image;
//                                                             }
//                                                         }];
    
}


@end

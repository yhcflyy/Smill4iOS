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
#import "UIImageView+LK.h"


@implementation PicViewCell



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
        
        self.contentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.contentImageView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:self.contentImageView];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.contentLabel];
        
    }
    
    return self;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.contentImageView.image = nil;
    self.contentLabel.text = nil;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    InfoModel *infoModel=self.object;
    
    CGFloat width = self.frame.size.width - MARGIN * 2;
    CGFloat top = MARGIN;
    CGFloat left = MARGIN;
    
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

    
    self.contentImageView.frame = CGRectMake(left + MARGIN, MARGIN + HEAD_WIDTH+top + actualSize.height, width - 2* MARGIN, self.imageHeight -MARGIN);
    
}

- (void)collectionView:(PSCollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index {
    [super collectionView:collectionView fillCellWithObject:object atIndex:index];
    InfoModel *infoModel=object;
    self.contentLabel.text = infoModel.context;
    self.userNameLabel.text=infoModel.publisher;
    self.publishDateLabel.text=infoModel.publishDate;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:infoModel.headImageUrl]];
    [UIImageView lk_setImageDownloadDelegate:self];
    __weak UIImageView *weakImageView = self.contentImageView;
    weakImageView.imageURL = [NSURL URLWithString:infoModel.imageUrl];
    //[self.contentImageView sd_setImageWithURL:showPicURL placeholderImage:nil usingProgressView:progress];
}

@end

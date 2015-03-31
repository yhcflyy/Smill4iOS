//
//  VideoViewCell.m
//  Smill4iOS
//
//  Created by yaohongchao on 3/28/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import "VideoViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+LK.h"

@implementation VideoViewCell

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
        
        self.videoView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.videoView.contentMode=UIViewContentModeScaleAspectFit;
        self.videoView.userInteractionEnabled=YES;
        [self addSubview:self.videoView];
        
        self.progressView=[[UIProgressView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.progressView];
        
        self.playBtn=[[UIButton alloc]initWithFrame:CGRectZero];
        [self.playBtn setImage:[UIImage imageNamed:@"video-play.png"] forState:UIControlStateNormal];
        [self.playBtn addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.playBtn];
    }
    
    return self;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    AVPlayer *player=[[AVPlayerManager GetInstance] getAVPlayer];
    [player seekToTime:CMTimeMake(0, 1)];
    [player pause];
    self.playBtn.hidden=NO;
    self.videoView.layer.sublayers = nil;
    self.contentLabel.text = nil;
}

-(void)playVideo:(UIButton*)sender{
    VideoInfo *infoModel=self.object;
    AVPlayer* player=[[AVPlayerManager GetInstance] getAVPlayer];
    //if(infoModel.modelID != self.playingVideoID){
        AVPlayerLayer *playerLayer=[[AVPlayerManager GetInstance] getAVPlayerLayer:infoModel.videoURL];
        playerLayer.frame = self.videoView.bounds;
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.videoView.layer addSublayer:playerLayer];
        self.videoView.layer.frame=self.videoView.frame;
        
        [self removeNotification];
        [self addNotification];
        [self addProgressObserver];
    self.videoView.layer.backgroundColor=[UIColor greenColor].CGColor;
    CGRect rect=self.videoView.layer.frame;

  self.progressView.frame=CGRectMake(rect.origin.x,rect.origin.y + rect.size.height - 10, rect.size.width,5);

    if(player.rate == 0){
        [[AVPlayerManager GetInstance] play];
        self.playBtn.hidden=YES;
        //self.videoView.hidden=YES;
        NSLog(@"paly");
    }else if(player.rate == 1){
        [[AVPlayerManager GetInstance] pause];
        //self.videoView.hidden=NO;
        NSLog(@"pause");
    }
    self.playingVideoID=infoModel.modelID;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
  //  UITouch *aTouch = [touches anyObject];
    AVPlayer* player=[[AVPlayerManager GetInstance] getAVPlayer];
    if(player.rate == 1){
        [[AVPlayerManager GetInstance] pause];
        self.playBtn.hidden=NO;
    }
//    }else if(player.rate == 0){
//        [[AVPlayerManager GetInstance] play];
//        self.playBtn.hidden=YES;
//    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    VideoInfo *infoModel=self.object;
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
    self.videoView.frame = CGRectMake(left + MARGIN, MARGIN + HEAD_WIDTH+top + actualSize.height, width - 2* MARGIN, infoModel.videoHeight*0.5 -MARGIN);
    //self.progressView.frame=CGRectMake(left + MARGIN, self.imageHeight + HEAD_WIDTH+top + actualSize.height -10, self.videoView.frame.size.width,10);
    
    self.playBtn.frame=CGRectMake(0,0, 71, 71);
    self.playBtn.center=self.videoView.center;
}

- (void)collectionView:(PSCollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index {
    [super collectionView:collectionView fillCellWithObject:object atIndex:index];
    VideoInfo *infoModel=object;
    self.contentLabel.text = infoModel.context;
    self.userNameLabel.text=infoModel.publisher;
    self.publishDateLabel.text=infoModel.publishDate;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:infoModel.headImageUrl]];
    [self.videoView sd_setImageWithURL:[NSURL URLWithString:infoModel.imageURL]];
}


-(void)addProgressObserver{
    AVPlayer* player=[[AVPlayerManager GetInstance] getAVPlayer];
    AVPlayerItem *playerItem=player.currentItem;
    //UIProgressView *progress=self.progress;
    //这里设置每秒执行一次
    [player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current=CMTimeGetSeconds(time);
        float total=CMTimeGetSeconds([playerItem duration]);
        if (current) {
            [self.progressView setProgress:(current/total) animated:YES];
        }
    }];
}



/**
 *  添加播放器通知
 */
-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    AVPlayer* player=[[AVPlayerManager GetInstance] getAVPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:player.currentItem];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  播放完成通知
 *
 *  @param notification 通知对象
 */
-(void)playbackFinished:(NSNotification *)notification{
   [self.progressView setProgress:0 animated:NO];
    VideoInfo *info=self.object;
    AVPlayer *player=[[AVPlayerManager GetInstance] getAVPlayer];
    [player seekToTime:CMTimeMake(0, 1)];
    [player pause];
    self.playBtn.hidden=NO;
    [self.videoView sd_setImageWithURL:[NSURL URLWithString:info.imageURL]];

}


@end














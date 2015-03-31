//
//  VideoViewController.m
//  Smill4iOS
//
//  Created by flyy on 15/2/27.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoInfo.h"
#import "VideoViewCell.h"
#import "VideoModel.h"

@implementation VideoViewController
-(void)viewDidLoad{
    [super viewDidLoad];
}



-(void)refreshData{
    __weak BaseViewController *weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"a": @"newlist",@"type":@"41",@"c":@"video",@"page":@"1",@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.response.URL);
        self.curPage=1;
        VideoModel *picModel=[[VideoModel alloc] initWithDictionary:responseObject error:nil];
        [self.modelsArray removeAllObjects];
        [self.modelsArray addObjectsFromArray:picModel.list];
        [self dataSourceDidLoad];
        [weakSelf.collectionView.header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [weakSelf.collectionView.header endRefreshing];
        
    }];
    
}

-(void)LoadMore{
    __weak BaseViewController *weakSelf = self;
    NSString *strPage=[[NSString alloc] initWithFormat:@"%d",++self.curPage];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"a": @"newlist",@"type":@"41",@"c":@"video",@"page":strPage,@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.response.URL);
        [weakSelf.collectionView.footer endRefreshing];
        dispatch_main_sync_safe(^{
            VideoModel *picModel=[[VideoModel alloc] initWithDictionary:responseObject error:nil];
            for(VideoInfo *info in picModel.list){
                NSLog(@"%@",info.publisher);
            }
            [self.modelsArray addObjectsFromArray:picModel.list];
            [self dataSourceDidLoad];
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf.collectionView.footer endRefreshing];
        NSLog(@"Error: %@", error);
        self.curPage--;
    }];
}




- (void)dataSourceDidLoad {
    [self.collectionView reloadData];
}

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView {
    return [self.modelsArray count];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index {
    
    VideoInfo *infoModel=self.modelsArray[index];
    VideoViewCell *cell=(VideoViewCell*)[self.collectionView dequeueReusableViewForClass:[VideoViewCell class]];
    if(cell == nil){
        cell= [[VideoViewCell alloc] initWithFrame:CGRectZero];
    }
    CGFloat width=self.view.frame.size.width - MARGIN*2;
    CGFloat objectWidth =infoModel.videoWidth;
    CGFloat objectHeight =infoModel.videoHeight;
    CGFloat scaledHeight=((CGFloat)objectHeight/objectWidth)*width;
    
    //cell.imageHeight=scaledHeight;
    cell.layer.cornerRadius = 4;
    cell.backgroundColor=[UIColor whiteColor];
    
    
    [cell collectionView:self.collectionView fillCellWithObject:infoModel atIndex:index];
    return cell;
    
}
//-(void)playVideo:(id)sender{
//    //VideoInfo *infoModel=self.object;
//    [self.player play];
//    NSLog(@"hello");
//}
- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
    VideoInfo *infoModel=self.modelsArray[index];
    
    CGFloat height = 0.0;
    CGFloat width=self.view.frame.size.width - MARGIN*2;
    
    height += MARGIN*2;
    
    // Image
    CGFloat objectWidth =infoModel.videoWidth;
    CGFloat objectHeight =infoModel.videoHeight;
    if (objectHeight > objectWidth) {
        //CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
        CGFloat scaledHeight=objectHeight*0.5;
        height += scaledHeight;
        // Label
        //基本设置
        UIFont *textFont = [UIFont systemFontOfSize:17.0f];
        CGSize size = CGSizeMake(300, MAXFLOAT);
        //获取当前那本属性
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName, nil];
        //实际尺寸
        CGSize actualSize = [infoModel.context boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        height += actualSize.height + HEAD_WIDTH;
        return height;
    }else{
        //CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
        CGFloat scaledHeight=width*objectHeight/objectWidth;
        //CGFloat scaledHeight=((CGFloat)objectHeight/objectWidth)*width;
        height += scaledHeight;
        // Label
        //基本设置
        UIFont *textFont = [UIFont systemFontOfSize:17.0f];
        CGSize size = CGSizeMake(300, MAXFLOAT);
        //获取当前那本属性
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName, nil];
        //实际尺寸
        CGSize actualSize = [infoModel.context boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        height += actualSize.height + HEAD_WIDTH;
        
        return height;
    }
    
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index {
}




@end

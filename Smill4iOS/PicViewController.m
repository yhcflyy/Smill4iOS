//
//  PicViewController.m
//  Smill4iOS
//
//  Created by flyy on 15/2/27.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "PicViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+ProgressView.h"

@implementation PicViewController
int curPage;




-(void)refreshData{
    NSLog(@"width:%f.height:%f",[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
    __weak BaseViewController *weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"a": @"list",@"type":@"10",@"c":@"data",@"page":@"1",@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.response.URL);
        //NSLog(@"%@",responseObject);
        curPage=1;
        PicModel *picModel=[[PicModel alloc] initWithDictionary:responseObject error:nil];
        [self.modelsArray removeAllObjects];
        [self.modelsArray addObjectsFromArray:picModel.list];
        for (InfoModel* pic in self.modelsArray) {
            NSLog(@"%@",pic.imageUrl);
        }
        [self dataSourceDidLoad];
        [weakSelf.collectionView.pullToRefreshView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf.collectionView.pullToRefreshView stopAnimating];
    }];
}

-(void)LoadMore{
    __weak BaseViewController *weakSelf = self;
    NSString *strPage=[[NSString alloc] initWithFormat:@"%d",curPage++];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"a": @"list",@"type":@"10",@"c":@"data",@"page":strPage,@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_main_sync_safe(^{
            PicModel *picModel=[[PicModel alloc] initWithDictionary:responseObject error:nil];
            [self.modelsArray addObjectsFromArray:picModel.list];
            //[self.collectionView reloadData];
            [self dataSourceDidLoad];
            [weakSelf.collectionView.infiniteScrollingView stopAnimating];

        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        curPage--;
        [weakSelf.collectionView.infiniteScrollingView stopAnimating];
    }];
}

- (void)dataSourceDidLoad {
    [self.collectionView reloadData];
}





//- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView {
//    // NSLog(@"count:%d",self.modelsArray.count);
//    return 2;//self.modelsArray.count;
//}

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView {
    return [self.modelsArray count];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index {

    NSURL *url=[[NSURL alloc]initWithString:@"http://ww2.sinaimg.cn/large/005OPYkojw1ept1p5ma09j30dc080q32.jpg"];
    //        int height=((CGFloat)infoModel.picHeight/infoModel.picWidth)*cellWidth;
    PicViewCell *cell=(PicViewCell*)[self.collectionView dequeueReusableViewForClass:[PicViewCell class]];
    if(cell == nil){
        CGRect cellFrame = CGRectMake(0, 0,100 , 100);
        cell= [[PicViewCell alloc] initWithFrame:cellFrame];
    }
    
    [cell collectionView:self.collectionView fillCellWithObject:self atIndex:index];
    CGRect rect=CGRectMake(cell.bounds.origin.x + 20, cell.bounds.origin.y, cell.bounds.size.width - 40, cell.bounds.size.height);
    UIProgressView *pro=[[UIProgressView alloc]initWithFrame:rect];
    [cell.contentImageView sd_setImageWithURL:url  usingProgressView:pro];
    cell.titleLabel.text=@"Hello Text";
    return cell;

}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
    
    return 400;
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index {
    
}

@end

















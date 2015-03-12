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

#define MARGIN 8.0


@implementation PicViewController
int curPage;


-(void)viewDidLoad{
    [super viewDidLoad];
    [self refreshData];
}

-(void)refreshData{
    __weak BaseViewController *weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"a": @"list",@"type":@"10",@"c":@"data",@"page":@"1",@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.response.URL);
        curPage=1;
        PicModel *picModel=[[PicModel alloc] initWithDictionary:responseObject error:nil];
        [self.modelsArray removeAllObjects];
        [self.objectIdArray removeAllObjects];
        [self.modelsArray addObjectsFromArray:picModel.list];
        [self dataSourceDidLoad];
        [weakSelf.collectionView.pullToRefreshView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf.collectionView.pullToRefreshView stopAnimating];
    }];
}

-(void)LoadMore{
    __weak BaseViewController *weakSelf = self;
    NSString *strPage=[[NSString alloc] initWithFormat:@"%d",++curPage];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"a": @"list",@"type":@"10",@"c":@"data",@"page":strPage,@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.response.URL);
        dispatch_main_sync_safe(^{
            PicModel *picModel=[[PicModel alloc] initWithDictionary:responseObject error:nil];
            [self.modelsArray addObjectsFromArray:picModel.list];
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




- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView {
    return [self.modelsArray count];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index {

    InfoModel *infoModel=self.modelsArray[index];
    PicViewCell *cell=(PicViewCell*)[self.collectionView dequeueReusableViewForClass:[PicViewCell class]];
    if(cell == nil){
        cell= [[PicViewCell alloc] initWithFrame:CGRectZero];
    }

    cell.backgroundColor=[UIColor whiteColor];
    [cell collectionView:self.collectionView fillCellWithObject:infoModel atIndex:index];
    return cell;

}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
     InfoModel *infoModel=self.modelsArray[index];
    
    CGFloat height = 0.0;
    CGFloat width=self.view.frame.size.width - MARGIN*2;
    
    height += MARGIN;
    
    // Image
    CGFloat objectWidth =infoModel.picWidth;
    CGFloat objectHeight =infoModel.picHeight;
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    height += scaledHeight;
    // Label
    //基本设置
    UIFont *textFont = [UIFont systemFontOfSize:17.0f];
    CGSize size = CGSizeMake(300, MAXFLOAT);
    //获取当前那本属性
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName, nil];
    //实际尺寸
    CGSize actualSize = [infoModel.context boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    
    height += actualSize.height;
    
    return height;
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index {
    
}

@end

















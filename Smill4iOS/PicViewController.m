//
//  PicViewController.m
//  Smill4iOS
//
//  Created by flyy on 15/2/27.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "PicViewController.h"
#import "UIImageView+WebCache.h"


@implementation PicViewController


-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)refreshData{
    __weak BaseViewController *weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"a": @"list",@"type":@"10",@"c":@"data",@"page":@"1",@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.response.URL);
        self.curPage=1;
        PicModel *picModel=[[PicModel alloc] initWithDictionary:responseObject error:nil];
        [self.modelsArray removeAllObjects];
        [self.modelsArray addObjectsFromArray:picModel.list];
        [self dataSourceDidLoad];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [weakSelf.collectionView.header endRefreshing];

}

-(void)LoadMore{
    __weak BaseViewController *weakSelf = self;
    NSString *strPage=[[NSString alloc] initWithFormat:@"%d",++self.curPage];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"a": @"list",@"type":@"10",@"c":@"data",@"page":strPage,@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.response.URL);
        dispatch_main_sync_safe(^{
            PicModel *picModel=[[PicModel alloc] initWithDictionary:responseObject error:nil];
            [self.modelsArray addObjectsFromArray:picModel.list];
            [self dataSourceDidLoad];
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.curPage--;
    }];
    [weakSelf.collectionView.header endRefreshing];

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
    CGFloat width=self.view.frame.size.width - MARGIN*2;
    CGFloat objectWidth =infoModel.picWidth;
    CGFloat objectHeight =infoModel.picHeight;
    CGFloat scaledHeight=((CGFloat)objectHeight/objectWidth)*width;
    
       
    cell.imageHeight=scaledHeight;
    cell.layer.cornerRadius = 4;
    //cell.layer.masksToBounds = YES;
    cell.layer.shadowOpacity=0.5f;
    cell.layer.shadowOffset=CGSizeMake(0, 3);
    cell.layer.shadowRadius=5;
    
    cell.backgroundColor=[UIColor whiteColor];
    [cell collectionView:self.collectionView fillCellWithObject:infoModel atIndex:index];
    return cell;

}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
    InfoModel *infoModel=self.modelsArray[index];
    
    CGFloat height = 0.0;
    CGFloat width=self.view.frame.size.width - MARGIN*2;
    
    height += MARGIN*2;
    
    // Image
    CGFloat objectWidth =infoModel.picWidth;
    CGFloat objectHeight =infoModel.picHeight;
    //CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    CGFloat scaledHeight=((CGFloat)objectHeight/objectWidth)*width;
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

- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index {
}

@end

















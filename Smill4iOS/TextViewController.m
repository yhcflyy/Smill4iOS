//
//  TextViewController.m
//  Smill4iOS
//
//  Created by flyy on 15/2/27.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "TextViewController.h"
#import "UIImageView+WebCache.h"
#import "BaseViewCell.h"

@implementation TextViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}


-(void)refreshData{
    __weak TextViewController *weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"a": @"list",@"type":@"29",@"c":@"data",@"page":@"1",@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.response.URL);
        self.curPage=1;
        TextModel *picModel=[[TextModel alloc] initWithDictionary:responseObject error:nil];
        [self.modelsArray removeAllObjects];
        [self.modelsArray addObjectsFromArray:picModel.list];
        [self dataSourceDidLoad];
        [weakSelf.collectionView.header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf.collectionView.header endRefreshing];
        NSLog(@"%@",error);
    }];
}

-(void)LoadMore{
    __weak TextViewController *weakSelf = self;
    NSString *strPage=[[NSString alloc] initWithFormat:@"%d",++self.curPage];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"a": @"list",@"type":@"29",@"c":@"data",@"page":strPage,@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.response.URL);
        [weakSelf.collectionView.footer endRefreshing];
        dispatch_main_sync_safe(^{
            TextModel *picModel=[[TextModel alloc] initWithDictionary:responseObject error:nil];
            [self.modelsArray addObjectsFromArray:picModel.list];
            [self dataSourceDidLoad];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.curPage--;
        [weakSelf.collectionView.footer endRefreshing];
    }];
}

- (void)dataSourceDidLoad {
    [self.collectionView reloadData];
}


- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView {
    return [self.modelsArray count];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index {
    
    TextModel *textModel=self.modelsArray[index];
    BaseViewCell *cell=(BaseViewCell*)[self.collectionView dequeueReusableViewForClass:[BaseViewCell class]];
    if(cell == nil){
        cell= [[BaseViewCell alloc] initWithFrame:CGRectZero];
    }
    cell.layer.cornerRadius = 4;
//    //cell阴影
//    cell.layer.shadowOpacity=0.5f;
//    cell.layer.shadowOffset=CGSizeMake(0, 3);
//    cell.layer.shadowRadius=5;
    cell.backgroundColor=[UIColor whiteColor];
    [cell collectionView:self.collectionView fillCellWithObject:textModel atIndex:index];
    return cell;

    
}
- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
    BaseModel *infoModel=self.modelsArray[index];
    
    CGFloat height = 0.0;
    //CGFloat width=self.view.frame.size.width - MARGIN*2;
    
    height += MARGIN*2;
    

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

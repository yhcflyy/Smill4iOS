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
        curPage=1;
        PicModel *picModel=[[PicModel alloc] initWithDictionary:responseObject error:nil];
        [self.modelsArray removeAllObjects];
        [self.modelsArray addObjectsFromArray:picModel.list];
        [self.tableView reloadData];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf.tableView.pullToRefreshView stopAnimating];
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
            [self.tableView reloadData];
            [weakSelf.tableView.infiniteScrollingView stopAnimating];

        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        curPage--;
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.modelsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"reusedIdentifier";
    int cellWidth=[[UIScreen mainScreen] bounds].size.width - 20;
    UIImage* image=[UIImage imageNamed:@"2.jpg"];
    InfoModel *infoModel=self.modelsArray[indexPath.row];
    NSURL *url=[[NSURL alloc]initWithString:infoModel.imageUrl];
    int height=((CGFloat)infoModel.picHeight/infoModel.picWidth)*cellWidth;
    NSLog(@"screnn:%d",cellWidth);
    NSLog(@"per:%f,rw:%d,rh:%d,%d,publisher:%@",(CGFloat)infoModel.picHeight/infoModel.picWidth,infoModel.picWidth,infoModel.picHeight,height,infoModel.context);
    
    PicViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        CGRect cellFrame = CGRectMake(0, 0,cellWidth, height);
        cell= [[PicViewCell alloc] initWithFrame:cellFrame];
    }
//    CGRect cellFrame = [cell frame];
//    cellFrame.origin = CGPointMake(0, 0);
//    cellFrame.size.height=height;
//    [cell setFrame:cellFrame];
    
    CGRect rect=CGRectMake(cell.bounds.origin.x + 20, cell.bounds.origin.y, cell.bounds.size.width - 40, cell.bounds.size.height);
    UIProgressView *pro=[[UIProgressView alloc]initWithFrame:rect];
    [cell.contentImageView sd_setImageWithURL:url  usingProgressView:pro];
    cell.titleLabel.text=@"Hello Text";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    CGRect rect=tableView.bounds;
//    InfoModel *infoModel=self.modelsArray[indexPath.row];
//    int height=((CGFloat)infoModel.picHeight/infoModel.picWidth)*rect.size.width;
//    tableView.delegate=nil;
//    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
//    CGRect rect1=CGRectMake(cell.bounds.origin.x,cell.bounds.origin.y, cell.bounds.size.width,cell.bounds.size.height);
//    cell.bounds=rect1;
//    tableView.delegate=self;
    
    int cellWidth=[[UIScreen mainScreen] bounds].size.width - 20;
    InfoModel *infoModel=self.modelsArray[indexPath.row];
    int height=((CGFloat)infoModel.picHeight/infoModel.picWidth)*cellWidth;
    return height + 10;
    
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height + 10;
}

@end

















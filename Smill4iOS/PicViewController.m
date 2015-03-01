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
    __weak BaseViewController *weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"a": @"list",@"type":@"10",@"c":@"data",@"page":@"1",@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",[[operation request] URL]);
        curPage=1;
        PicModel *picModel=[[PicModel alloc] initWithDictionary:responseObject error:nil];
        [self.modelsArray removeAllObjects];
        [self.modelsArray addObjectsFromArray:picModel.list];
        NSLog(@"%d",picModel.totalPage);
        [self.tableView reloadData];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf.tableView.pullToRefreshView stopAnimating];
    }];
}

-(void)LoadMore{
    __weak BaseViewController *weakSelf = self;
    NSString *strPage=[[NSString alloc] initWithFormat:@"%d",curPage];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *parameters = @{@"a": @"list",@"type":@"10",@"c":@"data",@"page":strPage,@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",[[operation request] URL]);
        curPage++;
        PicModel *picModel=[[PicModel alloc] initWithDictionary:responseObject error:nil];
        [self.modelsArray addObjectsFromArray:picModel.list];
        NSLog(@"count:%lu",(unsigned long)self.modelsArray.count);
        [self.tableView reloadData];
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.modelsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"reusedIdentifier";
    PicViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell= [[PicViewCell alloc] init];
    }
    UIImage* image=[UIImage imageNamed:@"2.jpg"];
    InfoModel *infoModel=self.modelsArray[indexPath.row];
    NSLog(@"%d",indexPath.row);
    NSURL *url=[[NSURL alloc]initWithString:infoModel.imageUrl];
    //[cell.contentImageView sd_setImageWithURL:url placeholderImage:image];

    UIProgressView *pro=[[UIProgressView alloc]initWithFrame:[cell frame]];
    [cell.contentImageView sd_setImageWithURL:url placeholderImage:image usingProgressView:pro];
    cell.titleLabel.text=@"Hello Text";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 420;
}

@end

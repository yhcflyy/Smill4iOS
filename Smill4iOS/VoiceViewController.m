//
//  VoiceViewController.m
//  Smill4iOS
//
//  Created by flyy on 15/2/27.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "VoiceViewController.h"

@implementation VoiceViewController
//int curPage;
//-(void)refreshData{
//    __weak BaseViewController *weakSelf = self;
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"a": @"list",@"type":@"31",@"c":@"voice",@"page":@"1",@"per":@"15"};
//    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",[[operation request] URL]);
//        curPage=1;
//        [weakSelf.collectionView.pullToRefreshView stopAnimating];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [weakSelf.collectionView.pullToRefreshView stopAnimating];
//
//    }];
//}
//
//-(void)LoadMore{
//    __weak BaseViewController *weakSelf = self;
//    NSString *strPage=[[NSString alloc] initWithFormat:@"%d",curPage];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    NSString *strType=[[NSString alloc] initWithFormat:@"%d",self.type];
//    NSDictionary *parameters = @{@"a": @"list",@"type":strType,@"c":@"data",@"page":strPage,@"per":@"15"};
//    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [weakSelf.collectionView.infiniteScrollingView stopAnimating];
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [weakSelf.collectionView.infiniteScrollingView stopAnimating];
//
//    }];

//}


@end

//
//  BaseTableViewController.m
//  Smill4iOS
//
//  Created by flyy on 15/2/12.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BaseViewController

@synthesize type=_type;

int curPage;

-(instancetype)initWithType:(CONTROLLER_TYPE)type title:(NSString*)title{
    self=[super init];
    if(self){
        _type=type;
        self.title=title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    curPage=1;
    self.navigationItem.title=self.title;
    CGRect rect=CGRectMake(0, 70, self.view.bounds.size.width, self.view.bounds.size.height - 120);
    self.tableView=[[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
   
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.modelsArray=[[NSMutableArray alloc] init];
     __weak BaseViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf refreshData];
            }];
   
    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf LoadMore];
            }];
    
    [self.tableView triggerPullToRefresh];
    [self.tableView.pullToRefreshView setTitle:@"下拉刷新" forState:SVPullToRefreshStateStopped];
    [self.tableView.pullToRefreshView setTitle:@"释放更新" forState:SVPullToRefreshStateTriggered];
    [self.tableView.pullToRefreshView setTitle:@"更新..." forState:SVPullToRefreshStateLoading];
    rect=self.tableView.pullToRefreshView.frame;
    rect=CGRectMake(50, rect.origin.y, rect.size.width, rect.size.height);
    self.tableView.pullToRefreshView.frame=rect;
}
-(void)refreshData{}
-(void)LoadMore{}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

@end

































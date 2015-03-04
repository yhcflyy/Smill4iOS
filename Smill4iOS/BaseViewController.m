//
//  BaseTableViewController.m
//  Smill4iOS
//
//  Created by flyy on 15/2/12.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()<PSCollectionViewDataSource,PSCollectionViewDelegate>

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
    self.collectionView=[[PSCollectionView alloc]initWithFrame:rect ];
    __weak BaseViewController* weakSelf=self;
    self.collectionView.collectionViewDataSource=weakSelf;
    self.collectionView.collectionViewDelegate=weakSelf;
    [self.view addSubview:self.collectionView];
   
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.modelsArray=[[NSMutableArray alloc] init];
    [self.collectionView addPullToRefreshWithActionHandler:^{
        [weakSelf refreshData];
            }];
   
    // setup infinite scrolling
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [weakSelf LoadMore];
            }];
    
    [self.collectionView triggerPullToRefresh];
    [self.collectionView.pullToRefreshView setTitle:@"下拉刷新" forState:SVPullToRefreshStateStopped];
    [self.collectionView.pullToRefreshView setTitle:@"释放更新" forState:SVPullToRefreshStateTriggered];
    [self.collectionView.pullToRefreshView setTitle:@"更新..." forState:SVPullToRefreshStateLoading];
    rect=self.collectionView.pullToRefreshView.frame;
    rect=CGRectMake(50, rect.origin.y, rect.size.width, rect.size.height);
    self.collectionView.pullToRefreshView.frame=rect;
}
-(void)refreshData{}
-(void)LoadMore{}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

- (Class)collectionView:(PSCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index {
    return [PSCollectionViewCell class];
}

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView {
    return 0;
}

- (UIView *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index {
    return nil;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
    return 0.0;
}

@end

































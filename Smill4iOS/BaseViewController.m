//
//  BaseTableViewController.m
//  Smill4iOS
//
//  Created by flyy on 15/2/12.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()<UIScrollViewDelegate,PSCollectionViewDataSource,PSCollectionViewDelegate>

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

-(void)viewDidAppear:(BOOL)animated{
    __weak BaseViewController* weakSelf=self;
    
    
    [self.collectionView addPullToRefreshWithActionHandler:^{
        [weakSelf refreshData];
    }];
    
    // setup infinite scrolling
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [weakSelf LoadMore];
    }];
    
    
    [self.collectionView triggerPullToRefresh];//加载就更新
    [self.collectionView.pullToRefreshView setTitle:@"下拉刷新" forState:SVPullToRefreshStateStopped];
    [self.collectionView.pullToRefreshView setTitle:@"释放更新" forState:SVPullToRefreshStateTriggered];
    [self.collectionView.pullToRefreshView setTitle:@"更新..." forState:SVPullToRefreshStateLoading];
   }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    curPage=1;
    self.navigationItem.title=self.title;
    CGRect rect=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.collectionView=[[PSCollectionView alloc]initWithFrame:rect ];
    self.collectionView.backgroundColor=[UIColor colorWithRed:0.9294 green:0.9294 blue:0.9294 alpha:1];
    self.collectionView.delegate=self;
    self.collectionView.collectionViewDataSource=self;
    self.collectionView.collectionViewDelegate=self;
    self.collectionView.numColsPortrait = 1;
    [self.view addSubview:self.collectionView];
   
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.modelsArray=(NSMutableArray<BaseModel>*)[[NSMutableArray alloc] init];
    self.objectIdArray=[[NSMutableArray alloc]init];
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

































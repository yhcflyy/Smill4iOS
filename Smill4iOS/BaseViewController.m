//
//  BaseTableViewController.m
//  Smill4iOS
//
//  Created by flyy on 15/2/12.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "BaseViewController.h"
#import "SVPullToRefresh.h"
#import "PicViewCell.h"
#import "AFNetworking.h"
#import "JokeModel.h"
@interface BaseViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;
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
    CGRect rect=[[UIScreen mainScreen] bounds];
    
    self.tableView=[[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
   
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    
     __weak BaseViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf refreshData];
            }];
   
    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf LoadMore];
            }];
    
    [self.tableView triggerPullToRefresh];

}

-(void)refreshData{
    __weak BaseViewController *weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"a": @"list",@"type":@"10",@"c":@"data",@"page":@"1",@"per":@"15"};
    [manager GET:API_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf.tableView.pullToRefreshView stopAnimating];
        curPage=1;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)LoadMore{
        __weak BaseViewController *weakSelf = self;
//        NSString *strPage=[[NSString alloc] initWithFormat:@"%d",curPage++];
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        //NSDictionary *parameters = @{@"a": @"list",@"type":@"10",@"c":@"data",@"page":strPage,@"per":@"15"};
//        [manager GET:@"http://api.openweathermap.org/data/2.5/weather?lat=37.785834&lon=-122.406417&units=imperial" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            //NSLog(@"%@",responseObject);
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                                 options:NSJSONReadingMutableContainers
//                                                                   error:nil];
//            //将JSON数据和Model的属性进行绑定
//            CATProfile *model = [MTLJSONAdapter modelOfClass:[CATProfile class]
//                                          fromJSONDictionary:dict
//                                                       error:nil];
//            NSLog(@"%@",model);            [weakSelf.tableView.infiniteScrollingView stopAnimating];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Error: %@", error);
//        }];

    
    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/yhcflyy/Smill4iOS/develop/joke.json"];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError){
                               
                               if (!connectionError) {
                                   NSArray* jokes  = [JokeModel arrayOfModelsFromData:data error:nil];
                                   NSLog(@"joke:%d",jokes.count);
                                   [weakSelf.tableView.infiniteScrollingView stopAnimating];

                               }
                           }];
    //
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"reusedIdentifier";
    PicViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell= [[PicViewCell alloc] init];
        cell.contentImageView.image=[UIImage imageNamed:@"2.jpg"];
        cell.titleLabel.text=@"Hello Text";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}


@end

































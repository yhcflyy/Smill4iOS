//
//  BaseTableViewController.h
//  Smill4iOS
//
//  Created by flyy on 15/2/12.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "SVPullToRefresh.h"
#import "PicViewCell.h"
#import "AFNetworking.h"
#import "PicModel.h"

@interface BaseViewController : UIViewController
@property(nonatomic,assign)CONTROLLER_TYPE type;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSMutableArray<InfoModel>* modelsArray;
-(instancetype)initWithType:(CONTROLLER_TYPE)type title:(NSString*)title;

-(void)refreshData;
-(void)LoadMore;

@end

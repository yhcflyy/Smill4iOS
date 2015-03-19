//
//  BaseTableViewController.h
//  Smill4iOS
//
//  Created by flyy on 15/2/12.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "BaseViewCell.h"
#import "AFNetworking.h"
#import "PSCollectionView.h"
#import "PSCollectionViewCell.h"
#import "TextModel.h"
#import "MJRefresh.h"

@interface BaseViewController : UIViewController
@property(nonatomic,assign)CONTROLLER_TYPE type;
@property(nonatomic,strong)PSCollectionView* collectionView;
@property(nonatomic,strong)NSMutableArray<BaseModel>* modelsArray;
@property(assign,nonatomic)int curPage;

-(instancetype)initWithType:(CONTROLLER_TYPE)type title:(NSString*)title;

-(void)refreshData;
-(void)LoadMore;

@end

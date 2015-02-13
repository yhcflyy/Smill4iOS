//
//  BaseTableViewController.h
//  Smill4iOS
//
//  Created by flyy on 15/2/12.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

@interface BaseViewController : UIViewController
@property(nonatomic,assign)CONTROLLER_TYPE type;

-(instancetype)initWithType:(CONTROLLER_TYPE)type title:(NSString*)title;

@end

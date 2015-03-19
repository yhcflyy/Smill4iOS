//
//  BaseModel.h
//  Smill4iOS
//
//  Created by yaohongchao on 3/19/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol BaseModel @end

@interface BaseModel : JSONModel

@property(strong,nonatomic)NSString* publisher;
@property(strong,nonatomic)NSString* headImageUrl;
@property(strong,nonatomic)NSString* publishDate;
@property(strong,nonatomic)NSString* context;
@property(assign,nonatomic)int modelID;

@end

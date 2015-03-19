//
//  TextModel.h
//  Smill4iOS
//
//  Created by yaohongchao on 3/19/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
@interface TextModel : JSONModel
@property(assign,nonatomic)int totalPage;
@property(strong,nonatomic)NSArray<BaseModel>* list;
@end
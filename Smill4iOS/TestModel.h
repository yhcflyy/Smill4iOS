//
//  PicModel.h
//  Smill4iOS
//
//  Created by flyy on 15/2/26.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "listModel.h"
@interface TestModel : JSONModel

@property (strong, nonatomic) NSString* info;
@property (strong, nonatomic) NSString* name;
@property(strong,nonatomic) OwnerModel* owner;
@property(strong,nonatomic) NSArray<listModel,ConvertOnDemand>* list;
@end


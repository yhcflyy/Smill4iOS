//
//  BaseModel.m
//  Smill4iOS
//
//  Created by yaohongchao on 3/19/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"name": @"publisher",
                                                       @"created_at": @"publishDate",
                                                       @"profile_image":@"headImageUrl",
                                                       @"text": @"context",
                                                       @"id": @"modelID"
                                                       }];
}

@end

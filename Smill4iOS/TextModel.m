//
//  TextModel.m
//  Smill4iOS
//
//  Created by yaohongchao on 3/19/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import "TextModel.h"

@implementation TextModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"info.page": @"totalPage",
                                                       }];
}

@end

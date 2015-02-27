//
//  PicModel.m
//  Smill4iOS
//
//  Created by flyy on 15/2/27.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "PicModel.h"

@implementation PicModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"info.page": @"totalPage",
                                                       }];
}



@end

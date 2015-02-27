//
//  InfoModel.m
//  Smill4iOS
//
//  Created by flyy on 15/2/27.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"name": @"publisher",
                                                       @"created_at": @"publishDate",
                                                       @"text": @"context",
                                                       @"width": @"picWidth",
                                                       @"height": @"picHeight",
                                                       @"cdn_img": @"imageUrl",
                                                       @"is_gif": @"isGif"
                                                       }];
}


@end
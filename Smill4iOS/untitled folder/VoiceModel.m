//
//  VideoModel.m
//  Smill4iOS
//
//  Created by yaohongchao on 3/28/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import "VideoModel.h"

@implementation VoiceModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"info.page": @"totalPage",
                                                    }];
}


@end

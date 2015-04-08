//
//  VideoInfo.m
//  Smill4iOS
//
//  Created by yaohongchao on 3/28/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import "VideoInfo.h"

@implementation VoiceInfo

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"name": @"publisher",
                                                       @"created_at": @"publishDate",
                                                       @"profile_image":@"headImageUrl",
                                                       @"text": @"context",
                                                       @"id": @"modelID",
                                                       @"width":@"videoWidth",
                                                       @"height":@"videoHeight",
                                                       @"cdn_img":@"imageURL",
                                                       @"videouri":@"videoURL",
                                                       @"videotime":@"videoTime"
                                                       }];
}

@end

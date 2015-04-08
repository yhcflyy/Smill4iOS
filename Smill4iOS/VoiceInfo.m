//
//  VideoInfo.m
//  Smill4iOS
//
//  Created by yaohongchao on 3/28/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import "VoiceInfo.h"

@implementation VoiceInfo

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"name": @"publisher",
                                                       @"created_at": @"publishDate",
                                                       @"profile_image":@"headImageUrl",
                                                       @"text": @"context",
                                                       @"id": @"modelID",
                                                       @"width":@"imageWidth",
                                                       @"height":@"imageHeight",
                                                       @"cdn_img":@"imageURL",
                                                       @"voiceuri":@"voiceURL",
                                                       @"voicetime":@"voiceTime"
                                                       }];
}

@end

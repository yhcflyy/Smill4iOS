//
//  VideoModel.h
//  Smill4iOS
//
//  Created by yaohongchao on 3/28/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "VideoInfo.h"

@interface VoiceModel : JSONModel
@property(nonatomic,assign)int totalPage;
@property(nonatomic,strong)NSArray<VideoInfo>* list;
@end

//
//  InfoModel.h
//  Smill4iOS
//
//  Created by flyy on 15/2/27.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol InfoModel @end

@interface InfoModel : JSONModel
@property(strong,nonatomic)NSString* publisher;
@property(strong,nonatomic)NSString* headImageUrl;

@property(strong,nonatomic)NSString* publishDate;
@property(strong,nonatomic)NSString* context;
@property(assign,nonatomic)int picWidth;
@property(assign,nonatomic)int picHeight;
@property(strong,nonatomic)NSString* imageUrl;
@property(assign,nonatomic)BOOL isGif;
@property(assign,nonatomic)int modelID;

@end

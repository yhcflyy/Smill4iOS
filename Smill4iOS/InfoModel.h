//
//  InfoModel.h
//  Smill4iOS
//
//  Created by flyy on 15/2/27.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@protocol InfoModel @end

@interface InfoModel : BaseModel

@property(assign,nonatomic)int picWidth;
@property(assign,nonatomic)int picHeight;
@property(strong,nonatomic)NSString* imageUrl;
@property(assign,nonatomic)BOOL isGif;

@end

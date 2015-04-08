//
//  VideoInfo.h
//  Smill4iOS
//
//  Created by yaohongchao on 3/28/15.
//  Copyright (c) 2015 flyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@protocol VideoInfo @end

@interface VideoInfo : BaseModel
@property(assign,nonatomic)int imageWidth;
@property(assign,nonatomic)int imageHeight;
@property(strong,nonatomic)NSString* imageURL;
@property(strong,nonatomic)NSString* videoURL;
@property(assign,nonatomic)int videoTime;
@end

//
//  PicModel.h
//  Smill4iOS
//
//  Created by flyy on 15/2/26.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol PicInfoModel
@end

@interface PicInfoModel : JSONModel
@property(strong,nonatomic)NSString* name;
@property(strong,nonatomic)NSString* created_at;
@property(strong,nonatomic)NSString* text;
@property(strong,nonatomic)NSString* image1;
@end


@interface PicModel : JSONModel
@property (strong, nonatomic) NSArray<PicInfoModel>* list;
@end

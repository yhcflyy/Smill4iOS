//
//  TagModel.h
//  Smill4iOS
//
//  Created by flyy on 15/2/27.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol TagModel @end

@interface TagModel : JSONModel
@property (strong, nonatomic) NSString* id;
@property (strong, nonatomic) NSString* tag;

@end



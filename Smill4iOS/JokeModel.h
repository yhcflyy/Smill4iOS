//
//  PicModel.h
//  Smill4iOS
//
//  Created by flyy on 15/2/26.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagModel.h"
#import "JSONModel.h"


@interface JokeModel : JSONModel

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSArray<TagModel, Optional>* tags;

@end


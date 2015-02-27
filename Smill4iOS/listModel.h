//
//  TagModel.h
//  Smill4iOS
//
//  Created by flyy on 15/2/27.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol listModel @end

@interface listModel: JSONModel
@property (strong, nonatomic) NSString* ID;
@property (strong, nonatomic) NSString* url;
@end


@interface OwnerModel: JSONModel
@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString* name;
@end




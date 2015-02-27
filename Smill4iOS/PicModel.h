//
//  PicModel.h
//  Smill4iOS
//
//  Created by flyy on 15/2/27.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoModel.h"

@interface PicModel : JSONModel
@property(assign,nonatomic)int totalPage;
@property(strong,nonatomic)NSArray<InfoModel>* list;
@end



//
//  Config.h
//  Smill4iOS
//
//  Created by flyy on 15/2/12.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#ifndef Smill4iOS_Config_h
#define Smill4iOS_Config_h

typedef NS_ENUM(NSUInteger,CONTROLLER_TYPE){
    CONTROLLER_TYPE_TEXT,
    CONTROLLER_TYPE_PICTURE,
    CONTROLLER_TYPE_VOICE,
    CONTROLLER_TYPE_VIDEO
};

#define CONTENT_TYPE_TEXT  @"段子"
#define CONTENT_TYPE_PIC   @"图片"
#define CONTENT_TYPE_VOICE @"声音"
#define CONTENT_TYPE_VIDEO @"视频"
#endif

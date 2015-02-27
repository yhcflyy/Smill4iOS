//
//  BaseTabBarController.m
//  Smill4iOS
//
//  Created by flyy on 15/2/12.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseViewController.h"
#import "PicViewController.h"
#import "TextViewController.h"
#import "VideoViewController.h"
#import "VoiceViewController.h"

@implementation BaseTabBarController

+(instancetype)shareTabBarCtl{
    static BaseTabBarController* tabBarCtl;
    if(tabBarCtl){
        return tabBarCtl;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        tabBarCtl=[[self alloc] init];
        tabBarCtl.selectedIndex=1;
    });
    return tabBarCtl;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    //self.delegate=self;
   
    TextViewController* textCtl=[[TextViewController alloc] initWithType:CONTROLLER_TYPE_TEXT title:CONTENT_TYPE_TEXT];
    textCtl.tabBarItem=[[UITabBarItem alloc]initWithTitle:CONTENT_TYPE_TEXT image:[self getImage:@"tabbarEssay.png"]
                                           selectedImage:[self getImage:@"tabbarEssayClick.png"]];
    
    PicViewController* picCtl=[[PicViewController alloc] initWithType:CONTROLLER_TYPE_PICTURE title:CONTENT_TYPE_PIC];
    picCtl.tabBarItem=[[UITabBarItem alloc]initWithTitle:CONTENT_TYPE_PIC image:[self getImage:@"tabbarQuotation.png"]
                                             selectedImage:[self getImage:@"tabbarQuotationClick.png"]];

    VoiceViewController* voiceCtl=[[VoiceViewController alloc] initWithType:CONTROLLER_TYPE_VOICE title:CONTENT_TYPE_VOICE];
    voiceCtl.tabBarItem=[[UITabBarItem alloc]initWithTitle:CONTENT_TYPE_VOICE image:[self getImage:@"tabbarVoice.png"]
                                             selectedImage:[self getImage:@"tabbarVoiceClick.png"]];
    
    VideoViewController* videoCtl=[[VideoViewController alloc] initWithType:CONTROLLER_TYPE_VIDEO title:CONTENT_TYPE_VIDEO];
    
    videoCtl.tabBarItem=[[UITabBarItem alloc]initWithTitle:CONTENT_TYPE_VIDEO image:[self getImage:@"tabbarVideo.png"]
                                             selectedImage:[self getImage:@"tabbarVideoClick.png"]];
    
    NSArray* baseViewCtlArray=[NSArray arrayWithObjects:textCtl,picCtl,voiceCtl,videoCtl, nil];
    NSMutableArray* navArray=[[NSMutableArray alloc] init];
    for (BaseViewController* baseCtl in baseViewCtlArray) {
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:baseCtl];
        [navArray addObject:nav];
    }
        
    self.viewControllers=navArray;
    
    for (UITabBarItem *item in  self.tabBar.items) {
        [self changeTabBarItemFont:item];
    }
    [self.tabBar setAlpha:0.95];
}


-(UIImage*)getImage:(NSString*)path{
    return [[UIImage imageNamed:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)changeTabBarItemFont:(UITabBarItem*)item{
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Arial" size:11.5]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor redColor], NSForegroundColorAttributeName,
                                        [UIFont fontWithName:@"Arial" size:11.5],NSFontAttributeName,
                                        nil] forState:UIControlStateSelected];
}
@end




















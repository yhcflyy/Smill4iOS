//
//  BaseTabBarController.m
//  Smill4iOS
//
//  Created by flyy on 15/2/12.
//  Copyright (c) 2015年 flyy. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseTableViewController.h"

@implementation BaseTabBarController

+(instancetype)shareTabBarCtl{
    static BaseTabBarController* tabBarCtl;
    if(tabBarCtl){
        return tabBarCtl;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        tabBarCtl=[[self alloc] init];
    });
    return tabBarCtl;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    //self.delegate=self;
    BaseTableViewController* textCtl=[[BaseTableViewController alloc] initWithType:CONTROLLER_TYPE_TEXT
                                                                  uiTableviewStyle:UITableViewStylePlain];
    textCtl.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"段子" image:[self getImage:@"tabbarEssay.png"]
                                           selectedImage:[self getImage:@"tabbarEssayClick.png"]];
    
    BaseTableViewController* picCtl=[[BaseTableViewController alloc] initWithType:CONTROLLER_TYPE_PICTURE
                                                                  uiTableviewStyle:UITableViewStylePlain];
    picCtl.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"图片" image:[self getImage:@"tabbarQuotation.png"]
                                             selectedImage:[self getImage:@"tabbarQuotationClick.png"]];

    BaseTableViewController* voiceCtl=[[BaseTableViewController alloc] initWithType:CONTROLLER_TYPE_VOICE
                                                                 uiTableviewStyle:UITableViewStylePlain];
    voiceCtl.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"声音" image:[self getImage:@"tabbarVoice.png"]
                                             selectedImage:[self getImage:@"tabbarVoiceClick.png"]];
    
    BaseTableViewController* videoCtl=[[BaseTableViewController alloc] initWithType:CONTROLLER_TYPE_VIDEO
                                                                 uiTableviewStyle:UITableViewStylePlain];
    videoCtl.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"视频" image:[self getImage:@"tabbarVideo.png"]
                                             selectedImage:[self getImage:@"tabbarVideoClick.png"]];
    
    self.viewControllers=[NSArray arrayWithObjects:textCtl,picCtl,voiceCtl,videoCtl, nil];
    
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
                                        nil] forState:UIControlStateHighlighted];
}
@end




















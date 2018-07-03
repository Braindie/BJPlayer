//
//  MainTabBarController.m
//  BJPlayer
//
//  Created by zhangwenjun on 17/4/1.
//  Copyright © 2017年 zhangwenjun. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainViewCtrl.h"
#import "AVPlayerViewController.h"
#import "FFMpegViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addMVC];
    
}

- (void)addMVC{
    
    MainViewCtrl *vc1 = [[MainViewCtrl alloc] init];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"MediaPlayer"
                                                        image:[UIImage imageNamed:@"Main_tabBar10"]
                                                selectedImage:[UIImage imageNamed:@"Main_tabBar11"]];
    UINavigationController *mainVC = [[UINavigationController alloc] initWithRootViewController:vc1];
    [mainVC setTabBarItem:item1];
    
    AVPlayerViewController *vc2 = [[AVPlayerViewController alloc] init];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"AVFoundation"
                                                        image:[UIImage imageNamed:@"Main_tabBar12"]
                                                selectedImage:[UIImage imageNamed:@"Main_tabBar13"]];
    UINavigationController *avVC = [[UINavigationController alloc] initWithRootViewController:vc2];
    [vc2 setTabBarItem:item2];
    
    FFMpegViewController *vc3 = [[FFMpegViewController alloc] init];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"FFMpeg"
                                                        image:[UIImage imageNamed:@"Main_tabBar10"]
                                                selectedImage:[UIImage imageNamed:@"Main_tabBar11"]];
    UINavigationController *ffVC = [[UINavigationController alloc] initWithRootViewController:vc3];
    [vc3 setTabBarItem:item3];
    
    self.viewControllers = @[mainVC, avVC,ffVC];
    
}



@end

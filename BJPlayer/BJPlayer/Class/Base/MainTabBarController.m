//
//  MainTabBarController.m
//  BJPlayer
//
//  Created by zhangwenjun on 17/4/1.
//  Copyright © 2017年 zhangwenjun. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainViewCtrl.h"


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
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"多媒体"
                                                        image:[UIImage imageNamed:@"Main_tabBar10"]
                                                selectedImage:[UIImage imageNamed:@"Main_tabBar11"]];
    UINavigationController *mainVC = [[UINavigationController alloc] initWithRootViewController:vc1];
    [mainVC setTabBarItem:item1];
    
    self.viewControllers = @[mainVC];
    
}



@end

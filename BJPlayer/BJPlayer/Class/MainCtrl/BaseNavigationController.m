//
//  BaseNavigationController.m
//  BJPlayer
//
//  Created by zhangwenjun on 16/11/14.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import "BaseNavigationController.h"
#import "PlayerViewController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//允许旋转
- (BOOL)shouldAutorotate
{
    return YES;
}
/**
 *  topviewController就是当前导航控制器所控制的viewcontrol
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([self.topViewController isKindOfClass:[PlayerViewController class]])
    {
        return self.topViewController.supportedInterfaceOrientations;
    }
    return UIInterfaceOrientationMaskPortrait;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

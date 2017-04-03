//
//  AppDelegate.m
//  BJPlayer
//
//  Created by zhangwenjun on 16/9/19.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    

    
    

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    

//
    MainTabBarController *mainTBViewCtrl = [[MainTabBarController alloc] init];
    self.window.rootViewController = mainTBViewCtrl;

    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    
    
//    // 设定位置和大小
//    CGRect frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
//    //    frame.size = [UIImage imageNamed:@"loading.gif"].size;
//    // 读取gif图片数据
//    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"]];
//    // view生成
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
//    webView.userInteractionEnabled = NO;//用户不可交互
//    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:nil];
//    webView.backgroundColor = [UIColor blackColor];
//    webView.opaque = NO;
//    [self.window addSubview:webView];
    
    //沉睡3s进入主界面
//    [NSThread sleepForTimeInterval:3.0f];
    
//    [webView removeFromSuperview];
    
    
    
    return YES;
}


//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    return UIInterfaceOrientationMaskAll;//支持所有方向
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

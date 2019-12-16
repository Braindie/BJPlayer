//
//  BJAudioViewController.m
//  BJPlayer
//
//  Created by 张文军 on 2019/12/16.
//  Copyright © 2019 zhangwenjun. All rights reserved.
//

#import "BJAudioViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface BJAudioViewController ()
@property (nonatomic, strong) AVPlayer *cashPlayer;

@property (nonatomic, copy) NSString *urlStr;

@end

@implementation BJAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, 100, 50);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"获取本地url" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 200, 100, 50);
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"重播" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    self.urlStr = @"http://audio-1252935738.file.myqcloud.com/1533867727_0fdb8b8843466621fb27d1447519ba35.mp3";
    
    [self loadURLData];
}

- (void)loadURLData {
    NSURL *URL = [KTVHTTPCache proxyURLWithOriginalURL:[NSURL URLWithString:self.urlStr]];
    
    self.cashPlayer = [AVPlayer playerWithURL:URL];
    
    [self.cashPlayer play];
}

- (void)btnAction {
    NSURL *completeCacheFileURL= [KTVHTTPCache cacheCompleteFileURLWithURL:[NSURL URLWithString:self.urlStr]];
    NSLog(@"%@",completeCacheFileURL);
}

- (void)btn1Action {
    [self.cashPlayer play];
}

@end

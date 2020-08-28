//
//  AVPlayerViewController.m
//  BJPlayer
//
//  Created by zhangwenjun on 17/4/1.
//  Copyright © 2017年 zhangwenjun. All rights reserved.
//

#import "BJAVPlayerViewController.h"
#import "BJAVPlayerView.h"

@interface BJAVPlayerViewController ()
@property (nonatomic, strong) BJAVPlayerView *playerView;
@end

@implementation BJAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"AVPlayer";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildUI];
}

- (void)buildUI{
    self.playerView = [BJAVPlayerView initBJAVPlayerView];
    if (@available(iOS 11.0, *)) {
        self.playerView.frame = CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight*14/25);
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:self.playerView];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

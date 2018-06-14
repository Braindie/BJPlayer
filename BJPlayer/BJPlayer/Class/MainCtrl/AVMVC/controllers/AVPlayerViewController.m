//
//  AVPlayerViewController.m
//  BJPlayer
//
//  Created by zhangwenjun on 17/4/1.
//  Copyright © 2017年 zhangwenjun. All rights reserved.
//

#import "AVPlayerViewController.h"
#import "BJAVPlayerView.h"
#import "BJYoukuPlayerButton.h"

@interface AVPlayerViewController ()
@property (nonatomic, strong) BJAVPlayerView *playerView;
@property (nonatomic, strong) BJYoukuPlayerButton *youkuBtn;
@end

@implementation AVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"AVPlayer";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildUI];
}

- (void)buildUI{
    
    _youkuBtn = [[BJYoukuPlayerButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60) withState:BJYoukuPlayerButtonStatePlay];
    _youkuBtn.center = CGPointMake(self.view.center.x, self.view.center.y);
    [_youkuBtn addTarget:self action:@selector(youKuPlayMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_youkuBtn];
    
//    self.playerView = [BJAVPlayerView initBJAVPlayerView];
//    [self.view addSubview:self.playerView];
}

- (void)youKuPlayMethod{
    if (_youkuBtn.buttonState == BJYoukuPlayerButtonStatePause) {
        _youkuBtn.buttonState = BJYoukuPlayerButtonStatePlay;
    }else{
        _youkuBtn.buttonState = BJYoukuPlayerButtonStatePause;
    }
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

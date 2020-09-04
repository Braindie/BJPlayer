//
//  BJFFMpegPlayerViewController.m
//  BJPlayer
//
//  Created by 张文军 on 2020/8/27.
//  Copyright © 2020 zhangwenjun. All rights reserved.
//

#import "BJFFMpegPlayerViewController.h"

#import "BJFFMpegMovieManager.h"

#import "ST_AudioPlayer.h"

@interface BJFFMpegPlayerViewController (){
    ST_AudioPlayer *_aduioPlayer;
}

@property (nonatomic, strong) BJFFMpegMovieManager *video;
@property (nonatomic, assign) float lastFrameTime;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BJFFMpegPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"ffmpeg";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"播放" style:UIBarButtonItemStylePlain target:self action:@selector(playAction)];
    //    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [rightBarItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightBarItem;

    /// 播放容器
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*108/192)];
    self.imageView.center = self.view.center;
    self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.imageView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

//- (void)playAction {
//
//    NSString *filePath = [CommonUtil bundlePath:@"wildAnimal.mp4"];
//    _aduioPlayer = [[ST_AudioPlayer alloc] initWithFilePath:filePath];
//
//    [_aduioPlayer start];
//}

- (void)playAction {

//    NSString *url = @"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8";

//    NSString *url = @"http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8";

//    NSString *url = @"http://video.qulianwu.com/boomboom.mp4";

    NSString *url = [[NSBundle mainBundle] pathForResource:@"boomboom" ofType:@"mp4"];

//    NSString *url = @"http://ivi.bupt.edu.cn/hls/cctv3hd.m3u8";



    self.video = [[BJFFMpegMovieManager alloc] initWithVideo:url];

    int tns, thh, tmm, tss;
    tns = self.video.duration;
    thh = tns / 3600;
    tmm = (tns % 3600) / 60;
    tss = tns % 60;

    [self.video seekTime:0.0];

    [NSTimer scheduledTimerWithTimeInterval:1/self.video.fps repeats:YES block:^(NSTimer * _Nonnull timer) {
        // 下一帧
        [self.video stepFrame];

        // 获取下一帧画面
        NSLog(@"%@", self.video.currentImage);
        self.imageView.image = self.video.currentImage;
    }];
    
    _aduioPlayer = [[ST_AudioPlayer alloc] initWithFilePath:url];

    [_aduioPlayer start];
}


@end

//
//  PlayerViewController.m
//  BJPlayer
//
//  Created by zhangwenjun on 16/11/9.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import "PlayerViewController.h"
#import "MobilePlayerViewContrl.h"
#import "UIImageView+WebCache.h"


@interface PlayerViewController ()
// 播放控制器
@property (nonatomic, strong) MobilePlayerViewContrl *moviePlayerCtrl;

// 未播放时的背景图片//播放按钮视图（最好自己封装一个View）
@property (nonatomic, strong) UIImageView *backImageView;

// 视频资源数据
@property (nonatomic, strong) NSDictionary *urlDic;
@end

@implementation PlayerViewController

#pragma mark - cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MediaPlayer播放";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isLocalPlayer = YES;
    
    //初始化未播放时的界面
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - UI
- (void)initView{
    //背景图片
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, self.view.frame.size.width, self.view.frame.size.width*9/16)];
    self.backImageView.userInteractionEnabled = YES;
    self.backImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backImageView];
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1491214025476&di=e366ae73a26c02deb8b9ee93c63cca7b&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%253D580%2Fsign%3Defe9a6aa0e55b3199cf9827d73a88286%2F537a84d6277f9e2f4722f7a31b30e924b999f37c.jpg"]];
    
    /*毛玻璃效果*/
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*9/16);
    [self.backImageView addSubview:effectView];
    
    //播放按钮
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(self.backImageView.frame.size.width/2-50, self.backImageView.frame.size.height/2-50, 100, 100);
    [playBtn setImage:[UIImage imageNamed:@"player_pause_iphone_fullscreen"] forState:UIControlStateNormal];
    playBtn.backgroundColor = [UIColor clearColor];
    [playBtn addTarget:self action:@selector(playBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backImageView addSubview:playBtn];
}

- (void)playBtnAction{
    // 初始化视频播放器
    self.moviePlayerCtrl = [[MobilePlayerViewContrl alloc] init];
    self.moviePlayerCtrl.view.frame = CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenWidth*9/16);
    self.moviePlayerCtrl.myMoviePlayer.moviePlayer.allowsAirPlay = YES;
    [self.moviePlayerCtrl.myMoviePlayer.moviePlayer setShouldAutoplay:NO];
    
    [self addChildViewController:self.moviePlayerCtrl];
    [self.view addSubview:self.moviePlayerCtrl.view];
    
    // 初始化数据
    NSString *fileName = [NSString stringWithFormat:@"%@",self.downloadModel.title];
    NSString *filePath = [NSString stringWithFormat:@"%@",self.downloadModel.targetPath];
    NSLog(@"%@的文件路径为%@",fileName,filePath);
    if (_isLocalPlayer) {
        self.urlDic = [NSDictionary dictionaryWithObject:filePath forKey:@"myURL"];
        NSLog(@"%@的本地路径为%@",fileName,filePath);
    }else{
        self.urlDic = [NSDictionary dictionaryWithObject:self.downloadModel.savePath forKey:@"myURL"];
        NSLog(@"%@的网络路径为%@",fileName,self.downloadModel.savePath);
    }
    
//    NSString *str = [[NSBundle mainBundle] pathForResource:@"boomboom" ofType:@"mp4"];
    NSString *str = [[NSBundle mainBundle] pathForResource:@"wildAnimal" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:str];
    
    //隐藏蒙版
    self.backImageView.hidden=YES;
    //显示播放器
    self.moviePlayerCtrl.view.hidden = NO;
    //视频URL
    self.moviePlayerCtrl.myCourseDic = self.urlDic;
    //是否本地播放（必传）
    self.moviePlayerCtrl.isLocalPlay = self.isLocalPlayer;
    //调用播放方法
    [self.moviePlayerCtrl Play];
}


- (void)dealloc{

    [self.moviePlayerCtrl removeFromParentViewController];
    self.moviePlayerCtrl = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end

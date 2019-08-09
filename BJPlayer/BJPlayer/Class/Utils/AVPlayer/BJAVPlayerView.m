//
//  BJAVPlayerView.m
//  BJPlayer
//
//  Created by zhangwenjun on 17/4/6.
//  Copyright © 2017年 zhangwenjun. All rights reserved.
//

#import "BJAVPlayerView.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

@interface BJAVPlayerView (){
    
}
@property (nonatomic, assign) BOOL *isIntoBackground;
//播放视图
@property (weak, nonatomic) IBOutlet UIView *playerView;
//顶部视图
@property (weak, nonatomic) IBOutlet UIView *topView;
//返回按钮
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//更多按钮
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

//底部视图
@property (weak, nonatomic) IBOutlet UIView *downView;
//播放按钮
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
//已播放进度
@property (weak, nonatomic) IBOutlet UILabel *beginLabel;
//未播放进度
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
//播放进度条
@property (weak, nonatomic) IBOutlet UISlider *playProgress;
//缓存进度条
@property (weak, nonatomic) IBOutlet UIProgressView *loadedProgress;
//全屏按钮
@property (weak, nonatomic) IBOutlet UIButton *rotationBtn;
//屏幕播放按钮
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downViewBottom;

//是否显示工具条
@property (nonatomic, assign) BOOL isShowToolBar;


@end

@implementation BJAVPlayerView

+ (instancetype)initBJAVPlayerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"BJAVPlayerView" owner:self options:nil] lastObject];
}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"BJAVPlayerView" owner:self options:nil] lastObject];
//    }
//    return self;
//}

//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
////        [self buildUI];
//        self = [[[NSBundle mainBundle] loadNibNamed:@"BJAVPlayerView" owner:self options:nil] lastObject];
//
//    }
//    return self;
//}

- (void)awakeFromNib{
    [super awakeFromNib];
    _isShowToolBar = YES;
    self.playProgress.value = 0.0;
    self.loadedProgress.progress = 0.0;
    
    
    [self buildUI];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH*14/25);
    _playerLayer.frame = self.bounds;

}

- (void)buildUI{
    
    //初始化播放器
    self.player = [[AVPlayer alloc] init];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    [self.playerView.layer addSublayer:_playerLayer];
    
    //控件bringFront
    [self.playerView bringSubviewToFront:_topView];
    [self.playerView bringSubviewToFront:_downView];
    [self.playerView bringSubviewToFront:_playButton];
    
    
//    NSString *str = [[NSBundle mainBundle] pathForResource:@"boomboom" ofType:@"mp4"];//Bundle
////    NSString *str = [[NSBundle mainBundle] pathForResource:@"wildAnimal" ofType:@"mp4"];//Bundle
//    NSURL *url = [NSURL fileURLWithPath:str];
    
    NSURL *url = [NSURL URLWithString:@"http://video.qulianwu.com/boomboom.mp4"];
    _playerItem = [AVPlayerItem playerItemWithURL:url];
    [_player replaceCurrentItemWithPlayerItem:_playerItem];
    //观察status属性
    [_playerItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil];
    // 观察缓冲进度//一共有三种属性
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //监听播放进度
    
    
    
    // 播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    // 前台通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    // 后台通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)playbackFinished:(NSNotification *)notification {
//    NSLog(@"视频播放完成通知");
//    _playerItem = [notification object];
//    // 是否无限循环
//    [_playerItem seekToTime:kCMTimeZero]; // 跳转到初始
//    //    [_player play]; // 是否无限循环
}


#pragma mark KVO - status
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    AVPlayerItem *item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if (_isIntoBackground) {
            return;
        } else { // 判断status 的 状态
            AVPlayerStatus status = [[change objectForKey:@"new"] intValue]; // 获取更改后的状态
            if (status == AVPlayerStatusReadyToPlay) {
                NSLog(@"准备播放");
                // CMTime 本身是一个结构体
                CMTime duration = item.duration; // 获取视频长度
                NSLog(@"视频长度：%.2f", CMTimeGetSeconds(duration));
                // 设置视频时间
//                [self setMaxDuration:CMTimeGetSeconds(duration)];
                // 播放
                [self play];
                
            } else if (status == AVPlayerStatusFailed) {
                NSLog(@"AVPlayerStatusFailed");
            } else {
                NSLog(@"AVPlayerStatusUnknown");
            }
        }
        
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
//        NSTimeInterval timeInterval = [self availableDurationRanges]; // 缓冲时间
//        CGFloat totalDuration = CMTimeGetSeconds(_playerItem.duration); // 总时间
//        [self.loadedProgress setProgress:timeInterval / totalDuration animated:YES];
    } else {
        NSLog(@"Unknow");
    }
}

- (void)play {
    _isPlaying = YES;
    [_player play]; // 调用avplayer 的play方法
    self.playButton.alpha = 0;
}

#pragma mark - 处理点击事件
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_isShowToolBar) {
        [self portraitHide];
    } else {
        [self portraitShow];
    }
}

- (void)portraitHide{
    _isShowToolBar = NO;
    
    self.topViewTop.constant = -(self.topView.frame.size.height);
    self.downViewBottom.constant = -(self.downView.frame.size.height);
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];

        self.topView.alpha = 0;
        self.downView.alpha = 0;
        self.playButton.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
//在控制器中隐藏状态栏setStatusBarHidden，preferredStatusBarStyle
}
- (void)portraitShow{
    _isShowToolBar = YES;
    
    self.topViewTop.constant = 0;
    self.downViewBottom.constant = 0;
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];

        self.topView.alpha = 1;
        self.downView.alpha = 1;
        self.playButton.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

@end

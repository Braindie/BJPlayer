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

@interface BJAVPlayerView ()

// 相当于Controller层
@property (nonatomic, strong) AVPlayer *player;
// 相当于View层
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
// 相当于Model层
@property (nonatomic, strong) AVPlayerItem *playerItem;


// 是否正在播放
@property (nonatomic, assign) BOOL isPlaying;
//是否显示工具条
@property (nonatomic, assign) BOOL isShowToolBar;

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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downViewBottom;



@end

@implementation BJAVPlayerView

#pragma mark - cycle
+ (instancetype)initBJAVPlayerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"BJAVPlayerView" owner:self options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    _isPlaying = NO;
    _isShowToolBar = YES;
    self.playProgress.value = 0.0;
    self.loadedProgress.progress = 0.0;
    

    // 数据
//    [self loadData];
    [self loadCacheData];
    
    // UI
    [self.playerView.layer addSublayer:_playerLayer];
    [self.playerView bringSubviewToFront:_topView];
    [self.playerView bringSubviewToFront:_downView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 自定义的播放器View
    self.playerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*14/25);
    // 系统的播放器Layer
    self.playerLayer.frame = self.playerView.bounds;
}

#pragma mark -
- (void)loadData {
    
//    NSString *str = [[NSBundle mainBundle] pathForResource:@"boomboom" ofType:@"mp4"];
//    NSString *str = [[NSBundle mainBundle] pathForResource:@"wildAnimal" ofType:@"mp4"];
//    NSURL *url = [NSURL fileURLWithPath:str];
    
    
//    NSURL *url = [NSURL URLWithString:@"https://media.w3.org/2010/05/sintel/trailer.mp4"];

    NSURL *url = [NSURL URLWithString:@"http://video.qulianwu.com/boomboom.mp4"];
    _playerItem = [AVPlayerItem playerItemWithURL:url];
    
    // Model
    // KVO
    // 观察status属性
    [_playerItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil];
    // 观察缓冲进度
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    // 通知
    // 播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    // 进入后台
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
    // 进入前台
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    
    // Conroller
    _player = [[AVPlayer alloc] initWithPlayerItem:_playerItem];

    
    // View
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
}

- (void)loadCacheData {
//    NSURL *proxyUrl = [KTVHTTPCache proxyURLWithOriginalURL:[NSURL URLWithString:@"http://video.qulianwu.com/boomboom.mp4"]];
    NSURL *proxyUrl = [KTVHTTPCache proxyURLWithOriginalURL:[NSURL URLWithString:@"https://media.w3.org/2010/05/sintel/trailer.mp4"]];
    
    _player = [AVPlayer playerWithURL:proxyUrl];
    
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
//    [_player play];
}


#pragma mark - Action
// 播放、暂停
- (IBAction)playAndPauseAction:(id)sender {
    if (_isPlaying) {
        [_player pause];
        
        _isPlaying = NO;
        
    } else {
        [_player play];

        _isPlaying = YES;
    }
}

// 设置总时长
- (void) setMaxDuration:(float)time{
    NSLog(@"总时长%f",time);
}

// 视频播放完成通知
- (void)playbackFinished:(NSNotification *)notification {
    NSLog(@"视频播放完成通知");
    
    // 跳转到初始
    _playerItem = [notification object];
    [_playerItem seekToTime:kCMTimeZero];
}

// 隐藏工具条
- (void)portraitHide{
    _isShowToolBar = NO;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.topViewTop.constant = -(self.topView.frame.size.height);
        self.downViewBottom.constant = -(self.downView.frame.size.height);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.topView.hidden = YES;
        self.downView.hidden = YES;
    }];
}

// 显示工具条
- (void)portraitShow{
    _isShowToolBar = YES;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.topViewTop.constant = 0;
        self.downViewBottom.constant = 0;
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        self.topView.hidden = NO;
        self.downView.hidden = NO;
    }];
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    AVPlayerItem *item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        NSLog(@"status");
        if (_isIntoBackground) {
            return;
        } else {
            AVPlayerStatus status = [[change objectForKey:@"new"] intValue]; // 获取更改后的状态
            if (status == AVPlayerStatusReadyToPlay) {
                NSLog(@"AVPlayerStatusReadyToPlay");
                // 获取视频长度
                CMTime duration = item.duration;
                NSLog(@"视频长度：%.2f", CMTimeGetSeconds(duration));
                // 设置视频时间
                [self setMaxDuration:CMTimeGetSeconds(duration)];
            } else if (status == AVPlayerStatusFailed) {
                NSLog(@"AVPlayerStatusFailed");
            } else {
                NSLog(@"AVPlayerStatusUnknown");
            }
        }
        
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSLog(@"loadedTimeRanges");
//        NSTimeInterval timeInterval = [self availableDurationRanges]; // 缓冲时间
//        CGFloat totalDuration = CMTimeGetSeconds(_playerItem.duration); // 总时间
//        [self.loadedProgress setProgress:timeInterval / totalDuration animated:YES];
    } else {
        NSLog(@"Unknow");
    }
}


#pragma mark - Touch
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_isShowToolBar) {
        [self portraitHide];
    } else {
        [self portraitShow];
    }
}


@end

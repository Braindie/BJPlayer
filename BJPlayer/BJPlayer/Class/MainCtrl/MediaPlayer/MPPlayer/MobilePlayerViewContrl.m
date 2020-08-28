//
//  MobilePlayerViewContrl.m
//  MobileStudy
//
//  Created by zhangwenjun on 14/12/10.
//
//

#import "MobilePlayerViewContrl.h"

#define Use_TouchMovie 0

@interface MobilePlayerViewContrl ()<MovieControlsDelegate>

//播放控件视图
@property (nonatomic, strong) MovieControlsView *myMovieControlsView;

@property (nonatomic, copy) NSString *urlStr;

@property (nonatomic, assign) BOOL isplay;

@property (nonatomic, assign) BOOL istouched;//收放状态栏

@end

@implementation MobilePlayerViewContrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isplay = NO;
    
    //添加播放器
    [self AddNormalViews];
}


#pragma mark - 布局
-(void)AddNormalViews{
    
    //播放控制器
    self.myMoviePlayer = [[ MPMoviePlayerViewController alloc] init];
    self.myMoviePlayer.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    self.myMoviePlayer.moviePlayer.allowsAirPlay = YES;
    self.myMoviePlayer.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.myMoviePlayer.moviePlayer.fullscreen = NO;
    
    [self addChildViewController:self.myMoviePlayer];
    [self.view addSubview:self.myMoviePlayer.view];
   
    //添加控制界面（透明）
    self.myMovieControlsView = [[MovieControlsView alloc] init];
    self.myMovieControlsView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth*9/16);
    [self.myMoviePlayer.view addSubview:self.myMovieControlsView];
    self.myMovieControlsView.delegate = self;
    [self.view addSubview:self.myMovieControlsView];
}

#pragma mark - 外部调用播放事件
-(void)Play {

    //改变播放按钮状态
    [self ChangePlayingBtOn:NO];
    
    //准备播放
    [self playMovieWithUrl];
}

- (void)playMovieWithUrl {
    
    //先移除，再添加，解决内存问题
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    
    //播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
    //准备播放通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerPreparedToPlay:)
                                                 name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:nil];
    //播放状态变化通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerBackDidChanged)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];

    if (_isLocalPlay) {
        //本地视频（分为沙盒和Bundle中的视图）
        NSString *str = [[NSBundle mainBundle] pathForResource:@"boomboom" ofType:@"mp4"];
//        NSString *str = [[NSBundle mainBundle] pathForResource:@"wildAnimal" ofType:@"mp4"];
//        NSString *str = [self.myCourseDic objectForKey:@"myURL"];//沙盒绝对路径
        self.urlStr = [str copy];
    }else{
        //网络视频
//        _urlStr = @"http://120.25.226.186:32812/resources/videos/minion_02.mp4";
        NSString *str = [self.myCourseDic objectForKey:@"myURL"];
        self.urlStr = [str copy];
    }
    NSString* encodedString =[_urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [self.myMoviePlayer.moviePlayer prepareToPlay];
    self.myMoviePlayer.moviePlayer.movieSourceType = MPMovieLoadStateUnknown;
    if (_isLocalPlay) {
        //本地视频
        [self.myMoviePlayer.moviePlayer setContentURL:[NSURL fileURLWithPath:encodedString]];
    }else{
        //网络视频
        self.myMoviePlayer.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
        [self.myMoviePlayer.moviePlayer setContentURL:[NSURL URLWithString:encodedString]];
    }
    [self.myMoviePlayer.moviePlayer play];
    
}


#pragma mark - MovieControlsDelegate
//播放
-(void)playBtnClicked{
    if (!self.isplay){
        self.isplay = !self.isplay;
        [self.myMoviePlayer.moviePlayer play];
    }else{
        self.isplay = !self.isplay;
        [self.myMoviePlayer.moviePlayer pause];
    }
}

//返回
-(void)backBtnClicked{
    //    [self.delegate moviePlayerViewCtrlDismiss:YES AndLearnDic:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//拖动进度条，改变播放进度
-(void)ChangedValue:(float)value{
    NSTimeInterval timerr=self.myMoviePlayer.moviePlayer.duration*value;
    [self.myMoviePlayer.moviePlayer setCurrentPlaybackTime:timerr];
}

// 播放、暂停
- (BOOL)IsPlaying {
    return self.isplay;
}


#pragma mark 更新播放进度
-(void)UUpdateProgrss{
    
    float curTime= self.myMoviePlayer.moviePlayer.currentPlaybackTime;//当前播放时间
    float playableTime = self.myMoviePlayer.moviePlayer.playableDuration;//缓冲时间
    float allTime = self.myMoviePlayer.moviePlayer.duration;//总时长
    
    if (allTime <= 0.0) {
//        self.myMovieControlsView.playValueprogress=0;
//        self.myMovieControlsView.playableValueprogress=0;
    } else {
//        self.myMovieControlsView.playValueprogress=curTime/allTime;
//        self.myMovieControlsView.playableValueprogress=playableTime/allTime;
    }
}

#pragma mark 改变播放按钮状态事件
-(void)ChangePlayingBtOn:(BOOL) on{
    
    if (on) {//播放
        [self.myMovieControlsView.playBtn setImage:[UIImage imageNamed:@"video_play0"] forState:UIControlStateNormal];
    }else{//暂停
        [self.myMovieControlsView.playBtn setImage:[UIImage imageNamed:@"video_suspended0"] forState:UIControlStateNormal];
    }
}


#pragma mark - 播放通知方法
-(void)moviePlayerPreparedToPlay:(NSNotification*)notification {

}

-(void)moviePlayerBackDidFinish:(NSNotification *)notification {
    
}


//播放过程中调用的方法
-(void)moviePlayerBackDidChanged {
    BOOL tmp = NO;
    MPMoviePlaybackState playState = self.myMoviePlayer.moviePlayer.playbackState;
    switch (playState) {
        case MPMoviePlaybackStatePlaying:
        {
            tmp = YES;
            //播放暂停按钮显示为播放按钮
            [self ChangePlayingBtOn:YES];
            break;
        }
        case MPMoviePlaybackStateStopped:
        {
            break;
        }
        case MPMoviePlaybackStatePaused:
        {
            break;
        }
        case MPMoviePlaybackStateInterrupted:
        {
            break;
        }
        case MPMoviePlaybackStateSeekingForward:
        {
            break;
        }
        case MPMoviePlaybackStateSeekingBackward:
        {
            break;
        }
        default:
        {
            break;
        }
    }
    
    if (!tmp) {
        [self ChangePlayingBtOn:NO];
    }
}




#pragma mark - 触控事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch=[touches anyObject];
    
    CGFloat allTime=self.myMoviePlayer.moviePlayer.duration;
    
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    
    //点击过后一段时间，隐藏上下控件栏
    [self CheckWeatherHiddenWithPoint:previousPoint];
}

#pragma mark 检测是否隐藏bottomBar
- (void)CheckWeatherHiddenWithPoint:(CGPoint)point{
    
    /******方法用户增强用户体验，当用户在点击全屏或者播放的时候当点到bottomView的时候bottomView最好不隐藏*******/
    CGPoint pointBottom = [self.view convertPoint:point toView:self.myMovieControlsView.bottomViewBar];
    if (self.myMovieControlsView.bottomViewBar.hidden == NO){
        if (pointBottom.y > 0){//点击的是上下控件视图区域
            self.myMovieControlsView.bottomViewBar.hidden = NO;
            self.myMovieControlsView.topViewBar.hidden = NO;
        }else{//点击的是中间区域
            self.myMovieControlsView.bottomViewBar.hidden = YES;
            self.myMovieControlsView.topViewBar.hidden = YES;
        }
    }
    else
    {
        self.myMovieControlsView.bottomViewBar.hidden=self.istouched;
        self.myMovieControlsView.topViewBar.hidden=self.istouched;
    }
    
    self.istouched=!self.istouched;
}

@end

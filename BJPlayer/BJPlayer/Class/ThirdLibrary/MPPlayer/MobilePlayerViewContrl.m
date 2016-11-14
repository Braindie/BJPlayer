//
//  MobilePlayerViewContrl.m
//  MobileStudy
//
//  Created by chenxili on 14/12/10.
//
//

#import "MobilePlayerViewContrl.h"
//#import "Mp3View.h"
#import "AppDelegate.h"
//#import "UploadManager.h"
//#import "GlobalFunc.h"
//#import "Base64+DES.h"
//#import "NSString+Digest.h"

#define Use_TouchMovie 0

@interface MobilePlayerViewContrl ()

@end

@implementation MobilePlayerViewContrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加播放器
    [self AddNormalViews];
}


#pragma mark - 布局
-(void)AddNormalViews{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SaveLearnRecords) name:@"SaveLearnRecords" object:nil];
    //    userCourseChapterTb=[LocalDataBase GetTableWithType:@"user_icr_rco" HasUser:NO];//断点播放
    //    [GlobalData GetInstance].GB_Playtime=0;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        //        currentDeviceModel=iPadModel;//设备类型为iPad
        self.view.frame=CGRectMake(0, 0, 1024, 768);
    }else{
        //        currentDeviceModel=iPhoneOriPodModel;//其他类型
    }
    
    //播放控制器
    self.myMoviePlayer=[[mobileMPMoviePlayerContrl alloc] init];
    self.myMoviePlayer.moviePlayer.scalingMode=MPMovieScalingModeAspectFit;
    self.myMoviePlayer.moviePlayer.allowsAirPlay=YES;
    self.myMoviePlayer.moviePlayer.controlStyle=MPMovieControlStyleNone;
    self.myMoviePlayer.moviePlayer.fullscreen = NO;
    //    [GlobalData GetInstance].NewmoviePlayer=self.myMoviePlayer.moviePlayer;
    //    [GlobalData GetInstance].NewmoviePlayer.shouldAutoplay = YES;
    [self addChildViewController:self.myMoviePlayer];
    [self.view addSubview:self.myMoviePlayer.view];
    
    
    //标识背景    //背景Logo
    self.playTopView = [[UIView alloc] init];
    self.playTopView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.playTopView.backgroundColor = [UIColor clearColor];
    self.playTopView.center=self.playLoadImgView.center;
    [self.view addSubview:self.playTopView];
    self.playLoadImgView = [[UIImageView alloc] init];
//    self.playLoadImgView.backgroundColor = [UIColor orangeColor];
    self.playLoadImgView.image = [UIImage imageNamed:@"diaobao"];
    self.playLoadImgView.frame = CGRectMake(self.view.frame.size.width/2-310/8, self.view.frame.size.height/2-424/8, 424/4, 310/4);
    [self.playTopView addSubview:self.playLoadImgView];
    
    
//    if ([GlobalData GetInstance].GB_ProductVesion != Hyundai_Version && [GlobalData GetInstance].GB_ProductVesion!=Mobile_Version)
//    {
//        [self.playTopView addSubview:self.playLoadImgView];
//        [[GlobalData GetInstance].NewmoviePlayer.view addSubview:self.playTopView];
//    }
    
    //
    self.hintView=[[myhintView alloc] init];
    self.hintView.hidden=YES;
    self.hintView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.hintView.frame=CGRectMake(0, 0, 140, 140);
    self.hintView.center=self.view.center;
//    [GlobalData GetInstance].hintView=self.hintView;
//    if ([GlobalData GetInstance].GB_ProductVesion != Hyundai_Version)
//    {
//        //        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//        //        [delegate.window addSubview:self.hintView];
//        [self.view addSubview:self.hintView];
//    }
    
    //添加控制界面（透明）
    [self  AddmovieControlsView];
    
    //
    [self AddOtherView];
}
//添加控制界面（透明）
-(void)AddmovieControlsView{
    self.myMovieControlsView=[[MovieControlsView alloc] init];
    [self.myMoviePlayer.view addSubview:self.myMovieControlsView];
    self.myMovieControlsView.delegate=self;
    [self.view addSubview:self.myMovieControlsView];
}

- (void)AddOtherView{
    self.myCourseBackView=[[UIView alloc] initWithFrame:CGRectMake(self.myMoviePlayer.view.frame.size.width-272, 0, 272,320)];
    //    self.myCourseBackView.backgroundColor=RGBACOLOR(0, 0, 0, 0.8);
    self.myCourseBackView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.myCourseBackView];
    
    self.topView=[[UIView alloc] init];
    self.topView.backgroundColor=RGBACOLOR(100, 100, 100, 0.7);
    self.topView.frame=CGRectMake(0, 0, 302, 60);
    
    //题目
    UILabel *titleLab=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    titleLab.text=@"目录";
    titleLab.backgroundColor=[UIColor clearColor];
    titleLab.textColor=[UIColor blackColor];
    titleLab.font=[UIFont systemFontOfSize:20];
    titleLab.textColor=[UIColor whiteColor];
    [self.topView addSubview:titleLab];
    
    //收起
    self.mybackBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    [GlobalFunc SetImageButton:self.mybackBtn Normal:@"video_back_b.png" Highlight:@"video_back_b0.png" Clicked:@""];
    self.mybackBtn.frame=CGRectMake(232, 20, 40, 40);
    [self.mybackBtn addTarget:self action:@selector(PackUpCourseTable) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.mybackBtn];
    [self.myCourseBackView addSubview:self.topView];
    
    self.myCourseTableView=[[CourseTableViewContrl alloc] init];
    self.myCourseTableView.delegate=self;
    
    self.myCourseTableView.view.frame=CGRectMake(0, 60, 272,320-60);
    //    self.myCourseTableView.view.frame=CGRectMake(0, 60, 362+GB_HorizonDifference,320+GB_HorizonDifference-60);
    
    [self.myCourseBackView addSubview:self.myCourseTableView.view];
    //    self.myCourseTableView.view.hidden=YES;
    self.myCourseBackView.hidden=YES;

}


#pragma mark - 外部调用播放事件
-(void) Play{
    
    isToPlay = YES;
    
    [self AddNotifications];
    //    [self.myMoviePlayer.moviePlayer stop];
    //    [GlobalData GetInstance].NewmoviePlayer=self.myMoviePlayer.moviePlayer;
    
    //点击播放按钮的时候使用定时器更新播放进度
    [myProgressTimer invalidate];
    myProgressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(UUpdateProgrss) userInfo:nil repeats:YES];
    [myProgressTimer fire];
    
    //从没有播放（是）
    hasNeverPlayed = YES;
    //等待标志（未隐藏）
    self.playTopView.hidden = NO;
    //改变播放按钮状态
    [self ChangePlayingBtOn:NO];
    //每次开始播放，播放时间置0
    GB_time=0;
    self.myMovieControlsView.playValueprogress=0;
    self.myMovieControlsView.playableValueprogress=0;
    
    //播放
    [self playMovieWithUrl];

    
//    [self getMovieMPArr];
//    [self moviePlayerSetContentUrl];
    
    
//    self.isLocalPlay = YES;
//    [self getMovieMPArr];
//    AVPlayerCtrl *ctrl = [[AVPlayerCtrl alloc] init];
//     NSDictionary *dic = [self.myMPArr objectAtIndex:0];
//    NSString *url = [dic objectForKey:@"url"];
//    ctrl.videoUrl = [NSURL URLWithString:url];
//    [self addChildViewController:ctrl];
//    [self.view addSubview:ctrl.view];
    
}

- (void)playMovieWithUrl{
    
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

    

    
//    NSString *url = [self.myCourseDic objectForKey:@"myURL"];
//    NSArray *tmpArr = [url componentsSeparatedByString:@"."];
//    //文件类型
//    NSString *fileType = [[tmpArr lastObject] lowercaseString];
    
    showErrTimes = 0;
    
    
    
    
    //http://120.25.226.186:32812/resources/videos/minion_01.mp4
    
    //网络视频
    //    NSString *url = @"http://120.25.226.186:32812/resources/videos/minion_01.mp4";
    
    //本地视频
    NSString *url = [[NSBundle mainBundle] pathForResource:@"wildAnimal" ofType:@"mp4"];
    
#if  0
    //测试高清视频时用的时时内容
    [GlobalData GetInstance].GB_EncodeKey = @"movieresource";
    NSString* encodedString = [NSString stringWithFormat:@"http://127.0.0.1:%d/zhuzixiaoout.mp4",GB_Port] ;
#else
    //将网址含有的中文、空格等转化
    NSString* encodedString =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#endif
    
    
    [self.myMoviePlayer.moviePlayer prepareToPlay];
    self.myMoviePlayer.moviePlayer.movieSourceType = MPMovieLoadStateUnknown;
        [self.myMoviePlayer.moviePlayer setContentURL:[NSURL fileURLWithPath:encodedString]];
//    [self.myMoviePlayer.moviePlayer setContentURL:[NSURL URLWithString:encodedString]];
    self.myMoviePlayer.moviePlayer.useApplicationAudioSession = NO;//放弃了
    [self.myMoviePlayer.moviePlayer play];
    

//    LOG_CSTRVALUE(@"最终播放地址", encodedString);
//    self.myMovieControlsView.titileLab.text=[dic objectForKey:@"title"];
//
//    //    [self performSelector:@selector(movieTimedOut) withObject:nil afterDelay:30.f];
//    [self.myCourseTableView.tableView reloadData];
//
//    [self.delegate DoRefreshOnMainThread];
    
}


#pragma mark 控件的代理方法
//播放
-(void)playBtnClicked{
    
    if (!isToPlay){
        isToPlay = !isToPlay;
        [self.myMoviePlayer.moviePlayer play];
        //            [[GlobalData GetInstance].NewmoviePlayer play];
    }else{
        isToPlay = !isToPlay;
        [self.myMoviePlayer.moviePlayer pause];
        //            [[GlobalData GetInstance].NewmoviePlayer pause];
    }
    //    if (hasNeverPlayed) {
    //        [self moviePlayerSetContentUrl];
    //    }
    //    else{
    //        isToPlay=!isToPlay;
    //    }
}
//返回
-(void)backBtnClicked{
    //    [self.delegate moviePlayerViewCtrlDismiss:YES AndLearnDic:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

//上一节
-(void)upBtnClicked
{
    self.myCourseBackView.hidden=YES;
    //    [GlobalData GetInstance].myPlaySourseType=nextPageType;
    if(self.myIndex==0)
    {
        [self AddStatusLabelWithText:@"已经是第一个了"];
    }
    else{
        [self SaveLearnRecords];
        self.myIndex--;
        [self moviePlayerSetContentUrl];
    }
}

//下一节
-(void)nextBtnClicked
{
    self.myCourseBackView.hidden=YES;
    //    [GlobalData GetInstance].myPlaySourseType=nextPageType;
    if(self.myIndex>=self.myMPArr.count-1)
    {
        [self AddStatusLabelWithText:@"已经是最后一个了"];
    }
    else{
        [self SaveLearnRecords];
        self.myIndex ++;
        [self moviePlayerSetContentUrl];
    }
}
//锁屏、解锁
-(void)lockBtnClicked
{
    //    GB_isLocked=!GB_isLocked;
}
//拖动进度条，改变播放进度
-(void)ChangedValue:(float)value
{
    //    NSTimeInterval timerr=[GlobalData GetInstance].NewmoviePlayer.duration*value;
    //    [[GlobalData GetInstance].NewmoviePlayer setCurrentPlaybackTime:timerr];
}
//展开课程列表
-(void)courseListBtnClicked
{
    self.myCourseBackView.hidden=NO;
    [self.myCourseTableView.tableView reloadData];
}
#pragma mark 播放通知方法
-(void)moviePlayerPreparedToPlay:(NSNotification*)notification{
    
    //    if ([GlobalData GetInstance].GB_Playtime>0) {
    ////        [GlobalData GetInstance].GB_Playtime=0;
    //        return;
    //    }
    
    if (self.isPrePlay==NO){
        self.isPrePlay=YES;
    }else{
        return;
    }
    
    //获得上次播放时间
    //    LocalDataBase *userCourseChapterTb001=[LocalDataBase GetTableWithType:@"user_icr_rco" HasUser:NO];
    //    NSDictionary *chapterDic=[self.myMPArr objectAtIndex:self.myIndex];
    //
    //    NSDictionary *userCourseChapterDic = [userCourseChapterTb001 GetOneRecordWithKeys:[NSArray arrayWithObjects:@"courseId",@"userid",@"chapterId", nil] Values:[NSArray arrayWithObjects:self.myCourseID,[GlobalData GetInstance].GB_UserID,[chapterDic objectForKey:@"chapterId"] , nil] UseUser:NO];
    //
    //    NSTimeInterval skipTime=0;
    //    if (userCourseChapterDic!=nil)
    //    {
    //        skipTime=[[userCourseChapterDic objectForKey:@"playTime"] floatValue];
    //    }
    //    else if([GlobalData GetInstance].GB_Playtime >0)
    //    {
    //        skipTime = [GlobalData GetInstance].GB_Playtime;
    //    }
    //    else if (skipTime !=skipTime)
    //    {
    //        skipTime=0.0f;
    //    }
    //
    //    self.playTopView.hidden=YES;
    //    [[GlobalData GetInstance].NewmoviePlayer setCurrentPlaybackRate:1.0];
    //    [[GlobalData GetInstance].NewmoviePlayer setCurrentPlaybackTime:skipTime];
}

-(void)moviePlayerBackDidFinish:(NSNotification *)notification{
    
    self.playTopView.hidden=YES;
    
    BOOL HasErr = NO;
    NSNumber *reason = [notification.userInfo valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    //    if(reason !=nil){
    //        NSInteger reasonAsInteger = [reason integerValue];
    //        switch (reasonAsInteger)
    //        {
    //            case MPMovieFinishReasonPlaybackEnded:
    //            {
    //                [self StopTimer];
    //
    //                if (self.myIndex<[self.myMPArr count]-1 && [self.myMPArr count]>1 && GB_courseDetailBack==NO && [GlobalData GetInstance].myPlaySourseType!=detailCelltype)//自动进入下一首
    //                {
    //                    [self nextPageCourse];
    //                    return;
    //                }
    //                else if(self.myIndex>=[self.myMPArr count]-1 && GB_courseDetailBack==NO)
    //                {
    //                    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayFinishAfter" object:[self.myMPArr objectAtIndex:self.myIndex]];
    //                    [self StopAndSaveLearnRecords];
    //                    return;
    //                }
    //                break;
    //            }
    //            case MPMovieFinishReasonPlaybackError:
    //            {
    //                if (showErrTimes == 0) {
    //                    if (self.isLocalPlay)
    //                    {
    ////                        [GlobalFunc ShowNormalAlert:@"此视频格式可能有问题，若重试后问题仍然存在，请与管理员联系！"];
    //                        [[GlobalData GetInstance] StartLocalServer];
    //                    }
    //                    else
    //                    {
    //                        if (GB_UseNetType == CanUse_No) {
    ////                            [self AddStatusLabelWithText:@"当前无网络连接，请检查网络后重试！"];
    //			    [GlobalFunc ShowNormalAlert:@"当前无网络连接，请检查网络后重试！"];
    //                        }
    //                        else{
    //                            [GlobalFunc ShowNormalAlert:@"课件地址不存在或播放时发生异常，请重试！"];
    //                        }
    //                    }
    //                    showErrTimes = 1;
    //                }
    //
    //                HasErr = YES;
    //
    //                //错误引起播放结束
    //                [self StopTimer];
    //                break;
    //            }
    //            case MPMovieFinishReasonUserExited:
    //            {
    //                //用户退出
    //                [self StopTimer];
    //                break;
    //            }
    //                
    //            default:
    //                break;
    //        }
    //        
    //    }
    
    
    //    if ([GlobalData GetInstance].myPlaySourseType!=detailCelltype && !HasErr){
    //        [self SaveLearnRecords];
    //    }
}


//播放过程中调用的方法
-(void)moviePlayerBackDidChanged{
    BOOL tmp = NO;
    MPMoviePlaybackState playState = self.myMoviePlayer.moviePlayer.playbackState;
    switch (playState) {
        case MPMoviePlaybackStatePlaying:
        {
            tmp = YES;
            //开播了
            hasNeverPlayed = NO;
            [self StopTimer];
            //隐藏等待标志
            self.playTopView.hidden=YES;
            //播放暂停按钮显示为播放按钮
            [self ChangePlayingBtOn:YES];
            //
            [self performSelectorOnMainThread:@selector(BeginTimer) withObject:nil waitUntilDone:NO];
            break;
        }
        case MPMoviePlaybackStateStopped:
        {
            [self StopTimer];
            break;
        }
        case MPMoviePlaybackStatePaused:
        {
            [self StopTimer];
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
        [self StopTimer];
    }
//    LOG_CMETHODBEGIN;
}

#pragma mark - 更新播放进度
-(void)UUpdateProgrss{
    
    //如果是点击了显示进度条
    if (istouched) {
        touchTime++;
        if (touchTime>=7)//大于7秒隐藏进度条
        {
            self.myMovieControlsView.topViewBar.hidden=YES;
            self.myMovieControlsView.bottomViewBar.hidden=YES;
            //            if (self.myMovieControlsView.isHorizontal && GB_SDK_Version>=7.0)
            //                //            if (self.myMovieControlsView.isHorizontal)
            //            {
            //                [[UIApplication sharedApplication] setStatusBarHidden:YES];
            //            }
            istouched = NO;
        }else{
            self.myMovieControlsView.topViewBar.hidden=NO;
            self.myMovieControlsView.bottomViewBar.hidden=NO;
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }
    }
    else{
        self.myMovieControlsView.topViewBar.hidden=YES;
        self.myMovieControlsView.bottomViewBar.hidden=YES;
        return;
    }
    
    float curTime= self.myMoviePlayer.moviePlayer.currentPlaybackTime;//当前播放时间
    float playableTime = self.myMoviePlayer.moviePlayer.playableDuration;//缓冲时间
    float allTime = self.myMoviePlayer.moviePlayer.duration;//总时长
    
    if (allTime <= 0.0) {
        self.myMovieControlsView.playValueprogress=0;
        self.myMovieControlsView.playableValueprogress=0;
    }
    else{
        //这个值有时候会是nan，所以得判断一下，防止崩溃
        if(isnan(curTime))
        {
            curTime=0;
        }
        
        self.myMovieControlsView.playValueprogress=curTime/allTime;
        self.myMovieControlsView.playableValueprogress=playableTime/allTime;
        
        
        //能播放的大于当前时间3秒，并且是暂停状态，并且非手动的关闭
        if ((playableTime > curTime+3) && !isPlaying && isToPlay) {
            [self.myMoviePlayer.moviePlayer play];
        }
        
    }
    
    self.myMovieControlsView.timeLab.text=[NSString stringWithFormat:@"%@/%@",[self getTimee:curTime],[self getTimee:allTime]];
    
    
    //    [self.myMovieControlsView UpdateFrame];
}
#pragma mark - 改变播放按钮状态事件
-(void)ChangePlayingBtOn:(BOOL) on{
    
    isPlaying = on;
    if (on) {//播放
        self.playTopView.hidden=YES;
        if (self.myMovieControlsView.isHorizontal){//横屏
            [self.myMovieControlsView.playBtn setImage:[UIImage imageNamed:@"suspended"] forState:UIControlStateNormal];
            //            [GlobalFunc SetImageButton:self.myMovieControlsView.playBtn Normal:@"suspended.png" Highlight:@"suspended0.png" Clicked:@""];
        }else{
            [self.myMovieControlsView.playBtn setImage:[UIImage imageNamed:@"video_play0"] forState:UIControlStateNormal];
            //            [GlobalFunc SetImageButton:self.myMovieControlsView.playBtn Normal:@"video_play0.png" Highlight:@"video_play.png" Clicked:@""];
        }
        
    }else{//暂停
        if([self HasPlayed]){
            self.playTopView.hidden=YES;
        }else{
            self.playTopView.hidden = NO;
        }
        
        if (self.myMovieControlsView.isHorizontal){//横屏
            [self.myMovieControlsView.playBtn setImage:[UIImage imageNamed:@"video_play_x"] forState:UIControlStateNormal];
            //            [GlobalFunc SetImageButton:self.myMovieControlsView.playBtn Normal:@"video_play_x.png" Highlight:@"video_play_x0.png" Clicked:@""];
        }else{
            [self.myMovieControlsView.playBtn setImage:[UIImage imageNamed:@"video_suspended0"] forState:UIControlStateNormal];
            //            [GlobalFunc SetImageButton:self.myMovieControlsView.playBtn Normal:@"video_suspended0.png" Highlight:@"video_suspended0.png" Clicked:@""];
        }
    }
}


#pragma mark - 触控事件
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch* touch=[touches anyObject];
    
    //优化触摸控制
    CGFloat changeX = [touch previousLocationInView:self.view].x - [touch locationInView:self.view].x;
    CGFloat changeY = [touch previousLocationInView:self.view].y - [touch locationInView:self.view].y;
    
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    CGPoint moviePoint=CGPointMake(previousPoint.x-startPoint.x, previousPoint.y-startPoint.y);

//    if (![self IsShowHintView:previousPoint]) {
//        return;
//    }
    
    
    if (startPoint.y > self.myMovieControlsView.frame.size.height - self.myMovieControlsView.bottomViewBar.frame.size.height && startPoint.y < self.myMovieControlsView.frame.size.height - self.myMovieControlsView.bottomViewBar.frame.size.height + 30) {

//        if (![self IsShowHintView:previousPoint]) {
//            return;
//        }
    }else if (startPoint.y < self.myMovieControlsView.frame.size.height - self.myMovieControlsView.bottomViewBar.frame.size.height){

        if (fabsf(changeX) > fabsf(changeY))
        {
            //如果是从来没有播放过，那么就直接返回
            if(![self HasPlayed])
            {
                return;
            }
//            PanStartLocation = progressStart;
            self.hintView.hidden=NO;
            if (changeX < 0.0)
            {
                self.hintView.types=progressTypeForwad;
            }
            else
            {
                self.hintView.types=progressTypeBackwad;
            }


            CGFloat allTime=self.myMoviePlayer.moviePlayer.duration;
            float progressTime=allTime*moviePoint.x/500;
            if (progressTime>5*3600)
            {
                progressTime=5*3600;
            }
            if (progressTime>(allTime-playingTime))
            {
                progressTime=allTime-playingTime;
            }
            if ((progressTime+playingTime)<0) {
                progressTime=-playingTime;
            }

            [self.hintView tinkerUp:progressTime+playingTime With:self.myMoviePlayer.moviePlayer.duration];
        }
        else
        {
            self.hintView.hidden=NO;
            
            if (YES){//音量控制
                MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];                CGFloat volume=0.0f;
                volume=startVolum-moviePoint.y/1000;

                if (volume>1.0f)
                {
                    volume=1.0f;
                }
                else if (volume<0.0f)
                {
                    volume=0.0f;
                }
                musicPlayer.volume=volume;

                self.hintView.types=volumType;
                [self.hintView tinkerUp:volume With:0.0];
                self.hintView.hidden=YES;

            }else if (NO){//亮度控制
                CGFloat light=0.0f;
                light=startLight-moviePoint.y/1000;
                if (light>1.0f)
                {
                    light=1.0f;
                }
                else if (light<0.0f)
                {
                    light=0.0f;
                }
                [[UIScreen mainScreen] setBrightness:light];

                self.hintView.types=lightType;
                [self.hintView tinkerUp:light With:0.0];
            }

        }
    }

//    CGPoint previousPoint = [touch previousLocationInView:self.view];
//    CGPoint moviePoint=CGPointMake(previousPoint.x-startPoint.x, previousPoint.y-startPoint.y);

    if(moviePoint.x/moviePoint.y > -0.3 && moviePoint.x/moviePoint.y < 0.3)
    {
        self.hintView.hidden=NO;

        if (YES){//音量控制
            MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
            CGFloat volume=0.0f;
            volume=startVolum-moviePoint.y/1000;

            if (volume>1.0f)
            {
                volume=1.0f;
            }
            else if (volume<0.0f)
            {
                volume=0.0f;
            }
            musicPlayer.volume=volume;

            self.hintView.types=volumType;
            [self.hintView tinkerUp:volume With:0.0];
            self.hintView.hidden=YES;

        }else if (NO){//亮度控制
            CGFloat light=0.0f;
            light=startLight-moviePoint.y/1000;
            if (light>1.0f)
            {
                light=1.0f;
            }
            else if (light<0.0f)
            {
                light=0.0f;
            }
            [[UIScreen mainScreen] setBrightness:light];

            self.hintView.types=lightType;
            [self.hintView tinkerUp:light With:0.0];
        }

    }
    else if (moviePoint.x/moviePoint.y>4.0 || moviePoint.x/moviePoint.y<-4.0)
    {
        //如果是从来没有播放过，那么就直接返回
        if(![self HasPlayed])
        {
            return;
        }

        self.hintView.hidden=NO;

//        PanStartLocation=progressStart;
        NSLog(@"%f======move",moviePoint.x);
        if (moviePoint.x>0.0)
        {
            self.hintView.types=progressTypeForwad;
        }
        else
        {
            self.hintView.types=progressTypeBackwad;
        }

        CGFloat allTime=self.myMoviePlayer.moviePlayer.duration;
        float progressTime=allTime*moviePoint.x/500;
        if (progressTime>5*3600)
        {
            progressTime=5*3600;
        }
        if (progressTime>(allTime-playingTime))
        {
            progressTime=allTime-playingTime;
        }
        if ((progressTime+playingTime)<0) {
            progressTime=-playingTime;
        }

        [self.hintView tinkerUp:progressTime+playingTime With:self.myMoviePlayer.moviePlayer.duration];

    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    playingTime = [GlobalData GetInstance].NewmoviePlayer.currentPlaybackTime;
    if (self.myCourseBackView.hidden== NO) {
        [self PackUpCourseTable];
        return;
    }
    UITouch* touch=[touches anyObject];
    startPoint = [touch previousLocationInView:self.view];//获取点击的位置
    
    if (!istouched) {
        touchTime = 0;
        [self.myMovieControlsView UpdateFrame];
        [self ChangePlayingBtOn:isPlaying];
    }
    
    /******方法用户增强用户体验，当用户在点击全屏或者播放的时候当点到bottomView的时候bottomView最好不隐藏*******/
    
    //    CGPoint pointBottom = [self.view convertPoint:startPoint toView:self.myMovieControlsView.bottomViewBar];
    //    if (self.myMovieControlsView.bottomViewBar.hidden == NO)
    //    {
    //        if (pointBottom.y > 0)
    //        {
    //            self.myMovieControlsView.bottomViewBar.hidden = NO;
    //            self.myMovieControlsView.topViewBar.hidden = NO;
    //        }
    //        else
    //        {
    //            self.myMovieControlsView.bottomViewBar.hidden = YES;
    //            self.myMovieControlsView.topViewBar.hidden = YES;
    //        }
    //    }
    //    else
    //    {
    //        self.myMovieControlsView.bottomViewBar.hidden=istouched;
    //        self.myMovieControlsView.topViewBar.hidden=istouched;
    //    }
    //
    ////    self.myMovieControlsView.topViewBar.hidden=istouched;
    ////    self.myMovieControlsView.bottomViewBar.hidden=istouched;
    //
    //
    //    istouched=!istouched;
    //
    //    if (self.myMovieControlsView.isHorizontal && GB_SDK_Version>=7.0)
    ////    if (self.myMovieControlsView.isHorizontal)
    //    {
    //        [[UIApplication sharedApplication] setStatusBarHidden:!istouched];
    //    }
    
    /*************************************************************************/
    
    
    
    //限制点击区域
    if (!self.myMovieControlsView.isHorizontal) {

        if (startPoint.y > self.myMovieControlsView.frame.size.height - self.myMovieControlsView.bottomViewBar.frame.size.height && startPoint.y < self.myMovieControlsView.frame.size.height - self.myMovieControlsView.bottomViewBar.frame.size.height + 30 && startPoint.x < self.myMovieControlsView.bottomViewBar.frame.size.width - 60) {

//            [self IsShowHintView:startPoint];
        }
    }else{
        if (startPoint.y > self.myMovieControlsView.frame.size.height - self.myMovieControlsView.bottomViewBar.frame.size.height && startPoint.y < self.myMovieControlsView.frame.size.height - self.myMovieControlsView.bottomViewBar.frame.size.height + 30) {

//            [self IsShowHintView:startPoint];
        }
    }
    
    
    if (startPoint.x>self.view.frame.size.width/2)
    {
        MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];//音量控制
        startVolum=musicPlayer.volume;
        //        PanStartLocation=volumStart;
    }
    else if (startPoint.x<=self.view.frame.size.width/2)
    {
        startLight=[UIScreen mainScreen].brightness;
        //        PanStartLocation=lightSrart;
    }
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch=[touches anyObject];
    
    self.hintView.hidden=YES;
    
    playingTime=self.myMoviePlayer.moviePlayer.currentPlaybackTime;
    CGFloat allTime=self.myMoviePlayer.moviePlayer.duration;
    
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    
    [self CheckWeatherHiddenWithPoint:previousPoint];
    
    
    CGPoint moviePoint=CGPointMake(previousPoint.x-startPoint.x, previousPoint.y-startPoint.y);
    if (YES){//进度控制
        
        float progressTime=allTime*moviePoint.x/500;
        if (progressTime>5*3600)
        {
            progressTime=5*3600;
        }
        if (progressTime>(allTime-playingTime))
        {
            progressTime=allTime-playingTime;
        }
        playingTime=playingTime+progressTime;
        
        if (playingTime>allTime)
        {
            playingTime=allTime;
        }
        else if (playingTime<0.0f)
        {
            playingTime=0.0f;
        }
        
        [self.myMoviePlayer.moviePlayer setCurrentPlaybackTime:playingTime];
    }
    
}


#pragma mark - 未整理
-(void) AddStatusLabelWithText:(NSString *) text{
    //    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    //    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    //
    //    while ([GlobalData GetInstance].GB_MainWaitView != nil)
    //    {
    //        for (NSString *mode in (__bridge NSArray *)allModes)
    //        {
    //            CFRunLoopRunInMode((__bridge CFStringRef)mode, 0.1, false);
    //        }
    //    }
    //    CFRelease(allModes);
    //
    //#if 0
    //
    //    if (progress == nil) {
    //        progress=[MBProgressHUD showHUDAddedTo:app.window animated:YES];
    //        progress.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"waitview.png"]];
    //        progress.mode = MBProgressHUDModeCustomView;
    //    }
    //
    //    progress.labelText = text;//@"加载中...";
    //    progress.delegate=  self;
    //    [progress show:YES];
    //    [progress hide:YES afterDelay:2];
    //    [progress bringToFront];
    //
    //#else
    //    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    //    //这种方法可以让加载过程中不响应点击事件。
    //    //    if ([GlobalData GetInstance].GB_MainWaitView == nil)
    //    {
    //        [GlobalData GetInstance].GB_MainWaitView = [[MBProgressHUD alloc] initWithView:delegate.window];
    //        [delegate.window addSubview:[GlobalData GetInstance].GB_MainWaitView];
    //        [GlobalData GetInstance].GB_MainWaitView.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"waitview.png"]];
    //        [GlobalData GetInstance].GB_MainWaitView.delegate = self;
    //        [GlobalData GetInstance].GB_MainWaitView.mode = MBProgressHUDModeCustomView;
    //        [GlobalData GetInstance].GB_MainWaitView.labelText = text;
    //
    //        [[GlobalData GetInstance].GB_MainWaitView show:YES];
    //
    //        [[GlobalData GetInstance].GB_MainWaitView hide:YES afterDelay:[text length]/8.0];
    //    }
    //
    //#endif
    
//    [[GlobalData GetInstance]  DoGCDQueue:text];
}


#pragma mark -
#pragma mark MBProgressHUDDelegate methods

//- (void)hudWasHidden:(MBProgressHUD *)hud{
//    GlobalData *gb = [GlobalData GetInstance];
//    @synchronized(gb.GB_MainWaitView)
//    {
//        [gb.GB_MainWaitView removeFromSuperview];
//        gb.GB_MainWaitView = nil;
//    }
//}

-(void) StopAndSaveLearnRecords
{
    [myProgressTimer invalidate];
    myProgressTimer = nil;
    [self StopTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if([self HasPlayed])//只有真正播放过才做进度回传操作
    {
        [self SaveLearnRecords];
    }
    [self.myMoviePlayer.moviePlayer stop];
//    GB_time = 0;
}

-(void) removeThisView
{
    [self StopAndSaveLearnRecords];
    [self.myMoviePlayer.view removeFromSuperview];
    [self.myMoviePlayer removeFromParentViewController];
    self.myMoviePlayer = nil;
    
    {//如果后台有播放，直接停止播放
//        [GlobalData GetInstance].NewmoviePlayer = nil;
    }
}

-(void)getMovieMPArr
{
    if ([[self.myCourseDic objectForKey:@"courseId"] length] > 0) {
        self.myCourseID = [self.myCourseDic objectForKey:@"courseId"];
    }
    
    //将视频、音频课件取出，放入新数组
    if(self.myMPArr == nil)
    {
        self.myMPArr=[NSMutableArray array];
        for (NSDictionary *dic in self.myMovieArray)//取出全部可播放课件
        {
            NSString *url = [dic objectForKey:@"url"];
//	      NSLog(@"url-=-=%@",url);
            NSArray *tmpArr = [url componentsSeparatedByString:@"."];
            //文件类型
            NSString *fileType = [[tmpArr lastObject] lowercaseString];
            if ([fileType isEqualToString:@"mp4"] || [fileType isEqualToString:@"mp3"] || [fileType isEqualToString:@"MP4"] || [fileType isEqualToString:@"MP3"])
            {
                if (self.isLocalPlay)
                {
                    NSString *fileName=nil;
                    fileName = [dic objectForKey:@"intFilePath"];
                    if (fileName == nil) {
                        fileName = [dic objectForKey:@"initFilePath"];
                    }

                    NSString *subPath = [NSString stringWithFormat:@"/%@/%@", self.myCourseID, fileName];
//                    NSString *strUrl = [NSString stringWithFormat:@"http://127.0.0.1:%d%@",GB_Port,subPath];
//                    [dic setValue:strUrl forKey:@"url"];
                }
                [self.myMPArr addObject:dic];
            }
        }
        
    }
    
    //重新确定self.myindex
    NSString *chaperId=[[self.myMovieArray objectAtIndex:self.myIndex] objectForKey:@"chapterId"];
    for (int i=0; i<[self.myMPArr count]; i++)
    {
        NSDictionary *dicc=[self.myMPArr objectAtIndex:i];
        if ([chaperId isEqualToString:[dicc objectForKey:@"chapterId"]])
        {
            self.myIndex=i;
        }
    }
    
    self.myCourseTableView.myCourseArr = self.myMPArr;
    
}

-(void) MakeSureIfShowMulu
{
    //优化，如果只有一个章节则不显示目录按钮
    if ([self.myMPArr count] <2) {
        self.myMovieControlsView.courseListBtn.hidden = YES;
    }
}
#pragma mark 弹出的课程列表代理方法
//收起弹出列表
-(void)PackUpCourseTable
{
    self.myCourseBackView.hidden=YES;
}
//点击弹出列表cell，切换播放章节
-(void)HaveCourseClicked:(int)index
{
//    [GlobalData GetInstance].myPlaySourseType=courseTableType;
    
    self.myCourseBackView.hidden=YES;
    //    self.myCourseTableView.view.hidden=YES;
    self.myIndex=index;
    //    [self InsertuserCourseChapterInfo];
    //    [self InsertOfflineLearnInfo];
    [self SaveLearnRecords];
    [self moviePlayerSetContentUrl];
}
#pragma mark -

//-(void)isHorizontalUpDate//横屏时
//{
//    moviePlayerCtrl.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    homeScrollView.hidden=YES;
//    self.myTopBar.hidden=YES;
//    seplineView1.hidden=YES;
//    seplineView2.hidden=YES;
//    moviePlayerCtrl.myMovieControlsView.isHorizontal=YES;
//
//}
//-(void)notHorizontalUpDate//竖屏时
//{
//    if (GB_isLocked) {
//        return;
//    }
//    moviePlayerCtrl.view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.width*9/16);
//
//    homeScrollView.hidden=NO;
//    self.myTopBar.hidden=NO;
//    seplineView1.hidden=NO;
//    seplineView2.hidden=NO;
//
//    moviePlayerCtrl.myMovieControlsView.isHorizontal=NO;
//
//}
//
//-(void)deviceOrientationDidChange:(NSObject*)sender{
//    UIDevice* device = [sender valueForKey:@"object"];
//
//    if (device.orientation == UIDeviceOrientationPortrait)
//    {
//        [self notHorizontalUpDate];
//    }
//    else if ( device.orientation == UIDeviceOrientationLandscapeLeft || device.orientation ==  UIDeviceOrientationLandscapeRight)
//    {
//        [self isHorizontalUpDate];
//    }
//
//    moviePlayerCtrl.myMovieControlsView.frame=CGRectMake(0, 0, moviePlayerCtrl.view.frame.size.width, moviePlayerCtrl.view.frame.size.height);
//    [moviePlayerCtrl.myMovieControlsView setNeedsDisplay];
//
//}

//屏幕转换
-(void)screenSwitchBtnClicked
{
    //    GB_isLocked=NO;
    //    UIApplication *application=[UIApplication sharedApplication];
    //    if (application.statusBarOrientation==UIDeviceOrientationLandscapeRight||application.statusBarOrientation==UIDeviceOrientationLandscapeLeft)
    //    {
    //        [application setStatusBarOrientation:UIInterfaceOrientationPortrait];
    //        self.myMovieControlsView.isHorizontal=NO;
    //
    //    }
    //    else
    //    {
    //        [application setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    //        self.myMovieControlsView.isHorizontal=YES;
    //
    //    }
    
    
    //    //旋转屏幕，但是只旋转当前的View
    //    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    //    self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
    //    CGRect frame = [UIScreen mainScreen].applicationFrame;
    //    self.view.bounds = CGRectMake(0, 0, frame.size.height, 375);
    
    
    //    application.keyWindow.transform=CGAffineTransformMakeRotation(M_PI/2);
    //    [self.myMovieControlsView setNeedsDisplay];
    
}

-(void) AddNotifications
{
    
    //    //准备播放通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(moviePlayerPreparedToPlay:)
    //                                                 name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
    //                                               object:nil];
    //    //播放状态变化通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(moviePlayerBackDidChanged)
    //                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
    //                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self.myMoviePlayer name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self.myMoviePlayer name:UIApplicationDidEnterBackgroundNotification object:nil];
    
}



//播放前全局字典，做播放记忆准备，即下次播放还从上次播放时间点开始
-(void)prepareForPlayTime:(NSDictionary *)dic
{
//    [[GlobalData GetInstance].GB_PlayerDic setValue:[GlobalData GetInstance].GB_UserID forKeyPath:@"userid"];
//    [[GlobalData GetInstance].GB_PlayerDic setValue:self.myCourseID forKeyPath:@"courseId"];
//    [[GlobalData GetInstance].GB_PlayerDic setValue:[dic objectForKey:@"chapterId"] forKeyPath:@"chapterId"];
//    [[GlobalData GetInstance].GB_PlayerDic setValue:@"" forKeyPath:@"state"];
//    [[GlobalData GetInstance].GB_PlayerDic setValue:@"" forKeyPath:@"suspendData"];
//    [[GlobalData GetInstance].GB_PlayerDic setValue:@"" forKey:@"playTime"];
}

#pragma mark - 获取路径，播放器播放
-(void)moviePlayerSetContentUrl{

    NSDictionary *dic = [self.myMPArr objectAtIndex:self.myIndex];//播放的列表
    [self prepareForPlayTime:dic];
    NSString *tempid=[dic objectForKey:@"chapterId"];
    self.myChapterID=[NSString stringWithString:tempid];
    for (int i=0;i<self.myMovieArray.count;i++)//详情的
    {
        NSMutableDictionary *dict=[self.myMovieArray objectAtIndex:i];
//        if([tempid isEqualToString:[dict objectForKey:@"chapterId"]])
//        {
//            if ([GlobalData GetInstance].myPlaySourseType!=topClickType)
//            {
//                [self.delegate reloadRowsCell:i];
//            }
//            
//            break ;
//        }
    }
    
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
    
//    GB_time=0;//每次开始播放，播放时间置0
    //进度归0
    {
        self.myMovieControlsView.playValueprogress=0;
        self.myMovieControlsView.playableValueprogress=0;
        //        [self performSelectorOnMainThread:@selector(UUpdateProgrss) withObject:nil waitUntilDone:NO];
    }
//    [GlobalData GetInstance].GB_Playtime=0;
    hasNeverPlayed = YES;
    self.playTopView.hidden=NO;
    
    [self ChangePlayingBtOn:NO];
    
    NSString *url = [dic objectForKey:@"url"];
    NSArray *tmpArr = [url componentsSeparatedByString:@"."];
    //文件类型
    NSString *fileType = [[tmpArr lastObject] lowercaseString];
    
    if ([fileType isEqualToString:@"mp3"] || [fileType isEqualToString:@"MP3"]) {
        int location = [url length] - 3;
        NSRange range;
        range.location = location;
        range.length = 3;
        NSString *tmpUrl = [url stringByReplacingCharactersInRange:range withString:@"lrc"];
        
//        Mp3View *mp3View = [[Mp3View alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//        mp3View.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
//        mp3View.PlayerC = [GlobalData GetInstance].NewmoviePlayer;
//        [[GlobalData GetInstance].NewmoviePlayer.view addSubview:mp3View];
//        [mp3View InitLRC:tmpUrl];
        
//        UIView *view = [[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject];
//        UIImageView *img = [[UIImageView alloc] initWithFrame:mp3View.bounds];
//        img.image = [UIImage imageNamed:@"mp3_bg.png"];
//        [view addSubview:img];
//        
//        [GlobalData GetInstance].GB_Mp3BGImage = img;
//        [GlobalData GetInstance].GB_Mp3BGImage.hidden = NO;
    }
    showErrTimes = 0;
#if  0
    //测试高清视频时用的时时内容
    [GlobalData GetInstance].GB_EncodeKey = @"movieresource";
    NSString* encodedString = [NSString stringWithFormat:@"http://127.0.0.1:%d/zhuzixiaoout.mp4",GB_Port] ;
#else
     NSString* encodedString =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将网址含有的中文、空格等转化
#endif
    [self.myMoviePlayer.moviePlayer prepareToPlay];
    self.myMoviePlayer.moviePlayer.movieSourceType = MPMovieLoadStateUnknown;
    [self.myMoviePlayer.moviePlayer setContentURL:[NSURL URLWithString:@""]];
    self.myMoviePlayer.moviePlayer.useApplicationAudioSession = NO;//放弃了
    
    [self.myMoviePlayer.moviePlayer play];
    
//    [[GlobalData GetInstance].NewmoviePlayer prepareToPlay];
//    [GlobalData GetInstance].NewmoviePlayer.movieSourceType = MPMovieSourceTypeUnknown;
//    [[GlobalData GetInstance].NewmoviePlayer setContentURL:[NSURL URLWithString:encodedString]];
//    [GlobalData GetInstance].NewmoviePlayer.useApplicationAudioSession=NO;
//    
//    [[GlobalData GetInstance].NewmoviePlayer play];
//
//    
//    LOG_CSTRVALUE(@"最终播放地址", encodedString);
//    self.myMovieControlsView.titileLab.text=[dic objectForKey:@"title"];
//    
//    //    [self performSelector:@selector(movieTimedOut) withObject:nil afterDelay:30.f];
//    [self.myCourseTableView.tableView reloadData];
//    
//    [self.delegate DoRefreshOnMainThread];
    
}
//-(void)movieTimedOut
//{
//    self.playTopView.hidden=YES;
//}

//方法类型：系统方法
//方法功能：缓冲结束时调用该方法
#pragma mark -
#pragma mark 自动播放下一章节
-(void)SaveLearnRecords
{
//    if ([GlobalData GetInstance].NewmoviePlayer == nil) {
//        return;
//    }
//    //不论从哪里来，先判断是否播放到文件最后，如果是，那么记录时间修改为0
//    playingTime=[GlobalData GetInstance].NewmoviePlayer.currentPlaybackTime;
//    if (playingTime>= [GlobalData GetInstance].NewmoviePlayer.duration - 1)
//    {
//        playingTime=0.0f;
//    }
//    
//    [self InsertuserCourseChapterInfo];//（保存播放点）
//    //        [self performSelectorInBackground:@selector(InsertuserCourseChapterInfo) withObject:nil];
//    
//    if (GB_OffLineLogin || GB_UseNetType == CanUse_No)
//    {
//        //保存离线学习进度
//        [self InsertOfflineLearnInfo];//（保存学习情况）
//        //            [self performSelectorInBackground:@selector(InsertOfflineLearnInfo) withObject:nil];
//        //离线时保存在本地，在线直接回传
//#if ISshowLearnCount
//        if (GB_UseNetType == CanUse_No)
//#else
//            if (GB_OffLineLogin)
//#endif
//            {
//                //                [self AddStatusLabelWithText:@"学习记录已经保存在本地，下次在线登录成功后，数据将提交到服务器！"];
//#if ISMobile_Version
//                [self AddStatusLabelWithText:@"学习记录已保存在本地，下次登录时将重新提交"];
//                
//#else
//                [self AddStatusLabelWithText:@"学习记录已经保存在本地，下次在线登录成功后，数据将提交到服务器！"];
//#endif
//            }
//        [self.delegate moviePlayerViewCtrlDismiss:NO AndLearnDic:nil];
//    }
//    else
//    {
//        if (GB_time==0)
//        {
//            return;
//        }
//        
//        NSDictionary *coursedic=[self.myMPArr objectAtIndex:self.myIndex];
//        [coursedic setValue:[self.myCourseDic objectForKey:@"classroomid"] forKey:@"classroomid"];
//        [coursedic setValue:[self.myCourseDic objectForKey:@"tbcId"] forKey:@"tbcId"];
//        [coursedic setValue:@"" forKey:@"suspendData"];
//        [coursedic setValue:@"" forKey:@"location"];
//        [coursedic setValue:@"0" forKey:@"grade"];
//        [coursedic setValue:[GlobalFunc GetStrFromFloat:GB_time] forKey:@"time"];
//        [coursedic setValue:[GlobalFunc GetStrFromInt:1] forKey:@"offltimes"];
//        [coursedic setValue:[GlobalFunc GetStrFromInt:[GlobalData GetInstance].NewmoviePlayer.currentPlaybackTime] forKey:@"timestamp"];
//        
//        float duration=[[coursedic objectForKey:@"duration"] intValue];
//        [coursedic setValue:[GlobalFunc GetStrFromFloat:duration] forKey:@"duration"];
//        [self performSelectorOnMainThread:@selector(uploadLearnProgressWithDic:) withObject:coursedic waitUntilDone:NO];
//        GB_time = 0;
//    }
}

-(void)uploadLearnProgressWithDic:(NSDictionary *)dic
{
//    [self.delegate UploadLearnProgressWithLearnDic:dic];
}

-(void)nextPageCourse
{
    
//    [GlobalData GetInstance].myPlaySourseType=nextPageType;
    [self SaveLearnRecords];
    //    if(GB_SDK_Version <= 6.0)
    //    {
    //        [GlobalFunc ShowNormalAlert:@"iOS 6.0以下设备不支持循环播放"];
    //        return ;
    //    }
    if(self.myIndex>=self.myMovieArray.count-1)
    {
        [self AddStatusLabelWithText:@"已经是最后一个视频了"];
        return ;
    }
    self.myIndex ++;
    [self moviePlayerSetContentUrl];
    
}
#pragma mark -
#pragma mark 计时器
//启动计时器
-(void) BeginTimer{
    [myTimer invalidate];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(Timing) userInfo:nil repeats:YES];
    [myTimer fire];
}

//停止计时器
-(void) StopTimer{
    [myTimer invalidate];
    myTimer = nil;
}

-(BOOL) IsPlaying{
    return isPlaying;
}

-(BOOL) HasPlayed{
    if (GB_time > 1) {
        return YES;
    }
    else{
        return NO;
    }
}

//取两位
-(NSString *)getStrr:(int)m{
    NSString *str01=nil;
    if (m<=9)
    {
        str01=[NSString stringWithFormat:@"0%d",m];
    }
    else
    {
        str01=[NSString stringWithFormat:@"%d",m];
    }
    return str01;
}

//将秒数 转化成时、分、秒
-(NSString *)getTimee:(int)t{
    int hour,minute,second;
    
    hour=t/3600; //int型整除
    minute=t%3600/60;
    second=t%60;
    NSString *hStr=[self getStrr:hour];
    NSString *mStr=[self getStrr:minute];
    NSString *sStr=[self getStrr:second];
    
    NSString *str02= nil;
    if (hour < 1) {
        str02=[NSString stringWithFormat:@"%@:%@",mStr,sStr];
    }
    else{
        str02=[NSString stringWithFormat:@"%@:%@:%@",hStr,mStr,sStr];
    }
    
    return str02;
}

//计时
-(void) Timing{
    GB_time++;
}


#pragma mark -
#pragma mark 离线、断点相关数据

-(void)InsertuserCourseChapterInfo
{
    
//    NSMutableDictionary *userCourseChapterDic=[NSMutableDictionary dictionaryWithCapacity:5];
//    NSDictionary *dic=[self.myMPArr objectAtIndex:self.myIndex];
//    [userCourseChapterDic setValue:[GlobalData GetInstance].GB_UserID forKeyPath:@"userid"];
//    [userCourseChapterDic setValue:self.myCourseID forKeyPath:@"courseId"];
//    [userCourseChapterDic setValue:[dic objectForKey:@"chapterId"] forKeyPath:@"chapterId"];
//    [userCourseChapterDic setValue:[dic objectForKey:@"state"] forKeyPath:@"state"];
//    [userCourseChapterDic setValue:[dic objectForKey:@"suspendData"] forKeyPath:@"suspendData"];
//    [userCourseChapterDic setValue:[NSString stringWithFormat:@"%f",playingTime] forKey:@"playTime"];
//    
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
//    NSString *date = [formatter stringFromDate:[NSDate date]];
//    [userCourseChapterDic setValue:date forKey:@"writeTime"];
//    
//    [userCourseChapterTb InsertDataWithDic:userCourseChapterDic Replace:YES];
}

//插入用户离线学习数据表
- (void)InsertOfflineLearnInfo
{
//    //学习情况表
//    learnTb = [LocalDataBase GetTableWithType:@"cst_performance" HasUser:NO];
//    NSDictionary *offlearnDic=[learnTb GetOneRecordWithKeys:[NSArray arrayWithObjects:@"userid",@"courseId",@"chapterId", nil] Values:[NSArray arrayWithObjects:[GlobalData GetInstance].GB_UserID,self.myCourseID,self.myChapterID, nil] UseUser:NO];
//    NSDictionary *chapterDic=[self.myMPArr objectAtIndex:self.myIndex];
//    
//    if (self.myCourseDic != nil)//有这条课程记录
//    {
//        NSMutableDictionary *learnDic = [NSMutableDictionary dictionaryWithCapacity:9];
//        
//        [learnDic setValue:[GlobalData GetInstance].GB_UserID forKey:@"userid"];
//        [learnDic setValue:self.myCourseID forKey:@"courseId"];
//        [learnDic setValue:self.myChapterID forKey:@"chapterId"];
//        [learnDic setValue:[self.myCourseDic objectForKey:@"classroomid"] forKey:@"classroomid"];
//        [learnDic setValue:[self.myCourseDic objectForKey:@"tbcId"] forKey:@"tbcId"];
//        [learnDic setValue:@"" forKey:@"suspendData"];
//        [learnDic setValue:@"" forKey:@"location"];
//        [learnDic setValue:@"0" forKey:@"grade"];
//        [learnDic setValue:[chapterDic objectForKey:@"type"] forKey:@"status"];
//        
//        if (offlearnDic!=nil)
//        {//已有学习记录，累加时间
//            float time=[[offlearnDic objectForKey:@"time"] floatValue];
//            [learnDic setValue:[GlobalFunc GetStrFromFloat:GB_time+time] forKey:@"time"];
//            int ltime=[[offlearnDic objectForKey:@"offltimes"] intValue];
//            [learnDic setValue:[GlobalFunc GetStrFromInt:ltime+1] forKey:@"offltimes"];
//        }
//        else
//        {
//            [learnDic setValue:[GlobalFunc GetStrFromFloat:GB_time] forKey:@"time"];
//            [learnDic setValue:[GlobalFunc GetStrFromInt:1] forKey:@"offltimes"];
//        }
//        
//        [learnDic setValue:[GlobalFunc GetStrFromInt:[GlobalData GetInstance].NewmoviePlayer.currentPlaybackTime] forKey:@"timestamp"];
//        
//        
//        //对字典中的数据加密一次, add by li at 20141222,此功能有众多模块，如有修改请全工程搜索@”by li at 20141222“替换
//        if([GlobalData GetInstance].GB_ProductVesion == Mobile_Version)
//        {
//            NSDictionary *tmpDic = [NSDictionary dictionaryWithDictionary:learnDic];
//            NSMutableString *tempStr = [NSMutableString stringWithCapacity:100];
//            
//            //这个可以用以下方法，因为有顺序关系
//            /*
//             for(NSString *key in tmpDic)
//             {
//             LOG_CINFO(key);
//             NSString *value = [tmpDic objectForKey:key];
//             LOG_CINFO(value);
//             
//             NSString* newValue = [Utility StringEncrpty:value];
//             [learnDic setValue:newValue forKey:key];
//             }
//             */
//#if 0   //字段都加密
//            NSString *chapterID = [Utility StringEncrpty:[tmpDic objectForKey:@"chapterId"]];
//            [tempStr appendString:[tmpDic objectForKey:@"chapterId"]];
//            [learnDic setValue:chapterID forKey:@"chapterId"];
//            
//            NSString *chapterTime = [Utility StringEncrpty:[tmpDic objectForKey:@"time"]];
//            [tempStr appendString:[tmpDic objectForKey:@"time"]];
//            [learnDic setValue:chapterTime forKey:@"time"];
//            
//            NSString *chapterTimestamp = [Utility StringEncrpty:[tmpDic objectForKey:@"timestamp"]];
//            [tempStr appendString:[tmpDic objectForKey:@"timestamp"]];
//            [learnDic setValue:chapterTimestamp forKey:@"timestamp"];
//            
//            NSString *offlineTimes = [Utility StringEncrpty:[tmpDic objectForKey:@"offltimes"]];
//            [tempStr appendString:[tmpDic objectForKey:@"offltimes"]];
//            [learnDic setValue:offlineTimes forKey:@"offltimes"];
//            
//            NSString *chapterType = [Utility StringEncrpty:[tmpDic objectForKey:@"status"]];
//            [tempStr appendString:[tmpDic objectForKey:@"status"]];
//            [learnDic setValue:chapterType forKey:@"status"];
//            
//            NSString *courseId = [Utility StringEncrpty:[tmpDic objectForKey:@"courseId"]];
//            [tempStr appendString:[tmpDic objectForKey:@"courseId"]];
//            [learnDic setValue:courseId forKey:@"courseId"];
//            
//            NSString *classroomid = [Utility StringEncrpty:[tmpDic objectForKey:@"classroomid"]];
//            [tempStr appendString:[tmpDic objectForKey:@"classroomid"]];
//            [learnDic setValue:classroomid forKey:@"classroomid"];
//            
//            NSString * tbcID= [Utility StringEncrpty:[tmpDic objectForKey:@"tbcId"]];
//            [tempStr appendString:[tmpDic objectForKey:@"tbcId"]];
//            [learnDic setValue:tbcID forKey:@"tbcId"];
//            
//            NSString *suspendData = [Utility StringEncrpty:[tmpDic objectForKey:@"suspendData"]];
//            [tempStr appendString:[tmpDic objectForKey:@"suspendData"]];
//            [learnDic setValue:suspendData forKey:@"suspendData"];
//            
//            NSString *location = [Utility StringEncrpty:[tmpDic objectForKey:@"location"]];
//            [tempStr appendString:[tmpDic objectForKey:@"location"]];
//            [learnDic setValue:location forKey:@"location"];
//            
//            NSString *grade = [Utility StringEncrpty:[tmpDic objectForKey:@"grade"]];
//            [tempStr appendString:[tmpDic objectForKey:@"grade"]];
//            [learnDic setValue:grade forKey:@"grade"];
//            
//            
//            NSString *userID = [Utility StringEncrpty:[GlobalData GetInstance].GB_UserID];
//            [tempStr appendString:[GlobalData GetInstance].GB_UserID];
//            [learnDic setValue:userID forKey:@"userid"];
//            
//#else //只加密新加两个字段
//            NSString *chapterID =[tmpDic objectForKey:@"chapterId"];
//            [tempStr appendString:chapterID];
//            [learnDic setValue:chapterID forKey:@"chapterId"];
//            
//            NSString *chapterTime = [tmpDic objectForKey:@"time"];
//            [tempStr appendString:chapterTime];
//            [learnDic setValue:chapterTime forKey:@"time"];
//            
//            NSString *chapterTimestamp = [tmpDic objectForKey:@"timestamp"];
//            [tempStr appendString:chapterTimestamp];
//            [learnDic setValue:chapterTimestamp forKey:@"timestamp"];
//            
//            NSString *offlineTimes = [tmpDic objectForKey:@"offltimes"];
//            [tempStr appendString:[tmpDic objectForKey:@"offltimes"]];
//            [learnDic setValue:offlineTimes forKey:@"offltimes"];
//            
//            NSString *chapterType = [tmpDic objectForKey:@"status"];
//            [tempStr appendString:[tmpDic objectForKey:@"status"]];
//            [learnDic setValue:chapterType forKey:@"status"];
//            
//            NSString *courseId = [tmpDic objectForKey:@"courseId"];
//            [tempStr appendString:[tmpDic objectForKey:@"courseId"]];
//            [learnDic setValue:courseId forKey:@"courseId"];
//            
//            NSString *classroomid = [tmpDic objectForKey:@"classroomid"];
//            [tempStr appendString:[tmpDic objectForKey:@"classroomid"]];
//            [learnDic setValue:classroomid forKey:@"classroomid"];
//            
//            NSString * tbcID= [tmpDic objectForKey:@"tbcId"];
//            [tempStr appendString:[tmpDic objectForKey:@"tbcId"]];
//            [learnDic setValue:tbcID forKey:@"tbcId"];
//            
//            NSString *suspendData = [tmpDic objectForKey:@"suspendData"];
//            [tempStr appendString:[tmpDic objectForKey:@"suspendData"]];
//            [learnDic setValue:suspendData forKey:@"suspendData"];
//            
//            NSString *location = [tmpDic objectForKey:@"location"];
//            [tempStr appendString:[tmpDic objectForKey:@"location"]];
//            [learnDic setValue:location forKey:@"location"];
//            
//            NSString *grade = [tmpDic objectForKey:@"grade"];
//            [tempStr appendString:[tmpDic objectForKey:@"grade"]];
//            [learnDic setValue:grade forKey:@"grade"];
//            
//            
//            NSString *userID = [GlobalData GetInstance].GB_UserID;
//            [tempStr appendString:[GlobalData GetInstance].GB_UserID];
//            [learnDic setValue:userID forKey:@"userid"];
//#endif
//            //添加新字段
//            NSString *uuid = getUUID();
//            NSString *newUUID = [Utility StringEncrpty:uuid];
//            [learnDic setValue:newUUID forKey:@"uuid"];
//            
//            [tempStr appendString:uuid];
//            
//            NSString *sha1Str = [tempStr SHA1];
//            NSString *newTempStr = [sha1Str MD5];
//            [learnDic setValue:newTempStr forKey:@"temp"];
//        }
//        
//        
//        LOG_CINFO(learnDic);
//        
//        //把数据插入表中
//        [learnTb InsertDataWithDic:learnDic Replace:YES];
//    }
    
}
-(void)readySumbitProgress
{
    
    //    if (GB_UseNetType != CanUse_No) {
    //        NSString *signType=[self.myCourseDetailDic  objectForKey:@"signType"];
    //        NSString *qppstatus=[self.myCourseDetailDic objectForKey:@"approvalStatus"];
    //        if([qppstatus isEqualToString:@"W"]&&[signType isEqualToString:@"A"])//已选
    //        {
    //            [GlobalFunc ShowNormalAlert:@"待审批状态无法上传学习进度"];
    //            return ;
    //        }
    //
    //        int selected = [[self.myCourseDic objectForKey:@"selected"] intValue];
    //        int elective = [[self.myCourseDic objectForKey:@"isElectives"] intValue];
    //
    //        if(elective == 1 && selected == 0)
    //        {
    //            //未选课询问是否选课
    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"不选课无法保存学习记录，是否确定选课？" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    //            alert.tag = 100;
    //            [alert show];
    //        }
    //        else
    //        {
    //            //已选课直接提交进度
    //            [[UploadManager GetUploadManager] StartUploadLearnningProgress];//上传学习记录
    //            [self.delegate MovieUpdateTopView];
    //        }
    //    }
    //    else
    //    {
    //        [[UploadManager GetUploadManager] StartUploadLearnningProgress];//上传学习记录
    //        [self.delegate MovieUpdateTopView];
    //
    //    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (alertView.tag == 100)
//    {//播放完成但是未选课弹提示框，是否选课
//        if (buttonIndex == 0)//是
//        {
//            [[UploadManager GetUploadManager] StartUploadLearnningProgress];//上传学习记录
//            [self.delegate MovieUpdateTopView];
//            
//        }
//        else
//        {
//            //如果不选课，学习记录从本地数据库中删除
//            [learnTb DeleteOneRecordWithKeys:[NSArray arrayWithObjects:@"userid",@"courseId", nil]
//                                      Values:[NSArray arrayWithObjects:[GlobalData GetInstance].GB_UserID,self.myCourseID, nil] UserUser:NO];
//            [userCourseChapterTb DeleteOneRecordWithKeys:[NSArray arrayWithObjects:@"userid",@"courseId", nil]
//                                                  Values:[NSArray arrayWithObjects:[GlobalData GetInstance].GB_UserID,self.myCourseID, nil] UserUser:NO];
//        }
//    }
//}
//
//-(BOOL) IsShowHintView:(CGPoint)point
//{
//    CGPoint pointBottom = [self.view convertPoint:point toView:self.myMovieControlsView.bottomViewBar];
//    float offX = pointBottom.x - self.myMovieControlsView.backProgressBar.left;
//    if (offX > 0 && (pointBottom.y -10 > 0 && pointBottom.y + 10 < self.myMovieControlsView.bottomViewBar.height)) {
//        float posX =  self.myMovieControlsView.playValueprogress*self.myMovieControlsView.backProgressBar.width;
//        if ((posX - offX > 10 || posX - offX < -10) && posX < self.myMovieControlsView.backProgressBar.width)//如果误差相差大于10，那么重新定位时间值
//        {
//            float newProgress = offX/self.myMovieControlsView.backProgressBar.width;
//            self.myMovieControlsView.playValueprogress = newProgress;
//            
//            [self.myMovieControlsView UpdateFrame];
//            CGFloat allTime=[GlobalData GetInstance].NewmoviePlayer.duration;
//            CGFloat curTime = newProgress*allTime;
//            self.myMovieControlsView.timeLab.text=[NSString stringWithFormat:@"%@/%@",[self getTimee:curTime],[self getTimee:allTime]];
//            
//            [[GlobalData GetInstance].NewmoviePlayer setCurrentPlaybackTime:curTime];
//        }
//        
//        return NO;
//    }
//    return YES;
}

//检测是否隐藏bottomBar
- (void)CheckWeatherHiddenWithPoint:(CGPoint)point
{
    //    CGPoint pointBottom = [self.view convertPoint:point fromView:self.myMovieControlsView.bottomViewBar];
    //    if (self.myMovieControlsView.bottomViewBar.hidden == NO)
    //    {
    //        if (pointBottom.y > 0)
    //        {
    //            self.myMovieControlsView.bottomViewBar.hidden = NO;
    //            self.myMovieControlsView.topViewBar.hidden = NO;
    //        }
    //        else
    //        {
    //            self.myMovieControlsView.bottomViewBar.hidden = YES;
    //            self.myMovieControlsView.topViewBar.hidden = YES;
    //        }
    //    }
    
    if (!istouched) {
        touchTime = 0;
        [self.myMovieControlsView UpdateFrame];
        [self ChangePlayingBtOn:isPlaying];
    }
    
    /******方法用户增强用户体验，当用户在点击全屏或者播放的时候当点到bottomView的时候bottomView最好不隐藏*******/
    
    CGPoint pointBottom = [self.view convertPoint:point toView:self.myMovieControlsView.bottomViewBar];
    if (self.myMovieControlsView.bottomViewBar.hidden == NO)
    {
        if (pointBottom.y > 0)
        {
            self.myMovieControlsView.bottomViewBar.hidden = NO;
            self.myMovieControlsView.topViewBar.hidden = NO;
        }
        else
        {
            self.myMovieControlsView.bottomViewBar.hidden = YES;
            self.myMovieControlsView.topViewBar.hidden = YES;
        }
    }
    else
    {
        self.myMovieControlsView.bottomViewBar.hidden=istouched;
        self.myMovieControlsView.topViewBar.hidden=istouched;
    }
    
    //    self.myMovieControlsView.topViewBar.hidden=istouched;
    //    self.myMovieControlsView.bottomViewBar.hidden=istouched;
    
    
    istouched=!istouched;
    
//    if (self.myMovieControlsView.isHorizontal && GB_SDK_Version>=7.0)
//        //    if (self.myMovieControlsView.isHorizontal)
//    {
//        [[UIApplication sharedApplication] setStatusBarHidden:!istouched];
//    }
}




#pragma mark --
#pragma mark 屏幕旋转

- (BOOL)shouldAutorotate
{
    return NO;
}
- (NSUInteger)supportedInterfaceOrientations
{
//    if (GB_isLocked)
//    {
//        return UIInterfaceOrientationMaskLandscape;
//    }
//    else
//    {
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//        
//    }
    return 1;
}

- (void)didReceiveMemoryWarning
{
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

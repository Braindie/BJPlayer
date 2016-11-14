//
//  MyMoviePlayerViewController.m
//  MobileStudy
//
//  Created by chenxili on 14-9-14.
//
//

#import "MyMoviePlayerViewController.h"
//#import "Mp3View.h"
#import "AppDelegate.h"
//#import "UploadManager.h"
#import "myhintView.h"


@interface MyMoviePlayerViewController ()
@end

@implementation MyMoviePlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)getMovieMPArr
{
    //将视频、音频课件取出，放入新数组
    self.myMPArr=[NSMutableArray array];
    for (NSDictionary *dic in self.myMovieArray)//取出全部可播放课件
    {
        NSString *url = [dic objectForKey:@"url"];
        NSArray *tmpArr = [url componentsSeparatedByString:@"."];
        //文件类型
        NSString *fileType = [[tmpArr lastObject] lowercaseString];
        if ([fileType isEqualToString:@"mp4"] || [fileType isEqualToString:@"mp3"] || [fileType isEqualToString:@"MP4"] || [fileType isEqualToString:@"MP3"])
        {
            if (self.isLocalPlay)
            {
                NSString *fileName=nil;
//                if (GB_OffLineLogin)
//                {
//                    fileName = [dic objectForKey:@"initFilePath"];
//                }
//                else
//                {
//                    fileName = [dic objectForKey:@"intFilePath"];
//                }
                NSString *subPath = [NSString stringWithFormat:@"/%@/%@", self.myCourseID, fileName];
//                NSString *strUrl = [NSString stringWithFormat:@"http://127.0.0.1:%d%@",GB_Port,subPath];
//                [dic setValue:strUrl forKey:@"url"];
            }
            [self.myMPArr addObject:dic];
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
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    userCourseChapterTb=[LocalDataBase GetTableWithType:@"user_icr_rco" HasUser:NO];//断点播放
//    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//    {
//        currentDeviceModel=iPadModel;//设备类型为iPad
//        self.view.frame=CGRectMake(0, 0, 1024, 768);
//    }
//    else
//    {
//        currentDeviceModel=iPhoneOriPodModel;//其他类型
//    }
    
    self.myMoviePlayer=[[MPMoviePlayerViewController alloc] init];
    self.myMoviePlayer.moviePlayer.scalingMode=MPMovieScalingModeAspectFit;
//    self.myMoviePlayer.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
    
    
    self.myMoviePlayer.moviePlayer.allowsAirPlay=YES;
    self.myMoviePlayer.moviePlayer.controlStyle=MPMovieControlStyleFullscreen;
//    [GlobalData GetInstance].NewmoviePlayer=self.myMoviePlayer.moviePlayer;
    [self.view addSubview:self.myMoviePlayer.view];
    
    //播放标志
    self.playLoadImgView = [[UIImageView alloc] init];
    self.playLoadImgView.image = [UIImage imageNamed:@"play_logo.png"];
    
    //标识背景
    self.playTopView = [[UIView alloc] init];
//    self.playTopView.backgroundColor = CreateColorByRGB(@"(082,081,081)");
    self.playTopView.center=self.playLoadImgView.center;
    
//    if ([GlobalData GetInstance].GB_ProductVesion != Hyundai_Version && [GlobalData GetInstance].GB_ProductVesion!=Mobile_Version)
//    {
//        [self.playTopView addSubview:self.playLoadImgView];
//        [[GlobalData GetInstance].NewmoviePlayer.view addSubview:self.playTopView];
//    }
//    
//    if (currentDeviceModel==iPadModel)//iPad
//    {
//        if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)
//        {
//            self.myMoviePlayer.view.frame=CGRectMake(0, -20, 1024, 768+20);
//        }
//        else
//        {
//            self.myMoviePlayer.view.frame=CGRectMake(0, 0, 1024, 768);
//        }
//        self.playLoadImgView.frame=CGRectMake((1024-795/2)/2, (768-174/2)/2, 795/2, 174/2);
//        self.playTopView.frame=CGRectMake(0, 0, 1024, 768);
//        
//    }
//    else//iPhone
//    {
//        if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)
//        {
//            self.myMoviePlayer.view.frame=CGRectMake(0, -20, self.view.width, self.view.height+20);
//        }
//        else
//        {
//            self.myMoviePlayer.view.frame=CGRectMake(0, 0, self.view.width, self.view.height);
//            
//        }
//        self.playLoadImgView.frame=CGRectMake((self.view.width-392/2)/2, (self.view.height-148/2)/2, 392/2, 148/2);
//        self.playTopView.frame=CGRectMake(0, 0, self.view.width, self.view.height+70);
//        
//        UIDevice *device = [UIDevice currentDevice];
//        switch (device.orientation) {
//            case UIDeviceOrientationLandscapeLeft:
//            case UIDeviceOrientationLandscapeRight:
//            {
//                self.playLoadImgView.frame=CGRectMake((self.view.height-392/2)/2, (320+GB_HorizonDifference-148/2)/2, 392/2, 148/2);
//                self.playTopView.frame = CGRectMake(0, 0, self.view.height, 320+GB_HorizonDifference);
//                
//                break;
//            }
//                
//            case UIDeviceOrientationPortrait:
//            case UIDeviceOrientationPortraitUpsideDown:
//            {
//                self.playLoadImgView.frame=CGRectMake((320+GB_HorizonDifference-392/2)/2, (self.view.height-148/2)/2, 392/2, 148/2);
//                self.playTopView.frame=CGRectMake(0,0, self.view.width, self.view.height+70);
//                
//                break;
//            }
//            default:
//                break;
//        }
//    }
    
//    if ([GlobalData GetInstance].GB_ProductVesion!=Mobile_Version)//非移动版本
//    {
//        [self getMovieMPArr];
//        [self moviePlayerSetContentUrl];
//    }
    
    //激活播放器的一些方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    //chenxili
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerPreparedToPlay:)
                                                 name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerBackDidChanged)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
    
//    if ([GlobalData GetInstance].GB_ProductVesion == Hyundai_Version)
//    {
//        return;
//    }
    
    
    UIButton *Upbut=nil;            //播放器的上一个
    UIButton *Nextbut=nil;            //播放器的下一个
    float version=[[[UIDevice currentDevice] systemVersion] floatValue];
    
//    if (currentDeviceModel==iPadModel) {
//        if (version>=7.0)
//        {
//            if (version>=8.0)
//            {
//                Upbut=(UIButton *)[[[[[[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] firstObject] subviews] firstObject] subviews] objectAtIndex:4] subviews] firstObject] subviews] lastObject] subviews] objectAtIndex:5];
//                
//                Nextbut=(UIButton *)[[[[[[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] firstObject] subviews] firstObject] subviews] objectAtIndex:4] subviews] firstObject] subviews] lastObject] subviews] objectAtIndex:6];
//            }
//            else
//            {
//                Upbut = (UIButton *)[[[[[[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] objectAtIndex:0] subviews] objectAtIndex:0] subviews] objectAtIndex:4] subviews] objectAtIndex:1] subviews] lastObject]subviews]objectAtIndex:1];
//                
//                Nextbut = (UIButton *)[[[[[[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] objectAtIndex:0] subviews] objectAtIndex:0] subviews] objectAtIndex:4] subviews] objectAtIndex:1] subviews] lastObject]subviews]objectAtIndex:3];
//            }
//        }
//        else//7.0以下
//        {
//            Upbut=(UIButton *)[[[[[[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] objectAtIndex:0] subviews] objectAtIndex:0] subviews] objectAtIndex:3] subviews] objectAtIndex:1] subviews] objectAtIndex:0] subviews] objectAtIndex:0];
//            
//            Nextbut=(UIButton *)[[[[[[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] objectAtIndex:0] subviews] objectAtIndex:0] subviews] objectAtIndex:3] subviews] objectAtIndex:1] subviews] objectAtIndex:0] subviews] objectAtIndex:2];
//        }
//        
//    }
//    else
//    {
//        if (version>=7.0)
//        {
//            if (version>=8.0)
//            {
//                Upbut=(UIButton *)[[[[[[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] firstObject] subviews] firstObject] subviews] objectAtIndex:4] subviews] firstObject] subviews] lastObject] subviews] objectAtIndex:5];
//                Nextbut=(UIButton *)[[[[[[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] firstObject] subviews] firstObject] subviews] objectAtIndex:4] subviews] firstObject] subviews] lastObject] subviews] objectAtIndex:6];
//                
//            }
//            else
//            {
//                //播放器的上一个
//                Upbut = (UIButton *)[[[[[[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] objectAtIndex:0] subviews] objectAtIndex:0] subviews] objectAtIndex:4] subviews] objectAtIndex:1] subviews] lastObject]subviews]objectAtIndex:1];
//                
//                //播放器的下一个
//                Nextbut = (UIButton *)[[[[[[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] objectAtIndex:0] subviews] objectAtIndex:0] subviews] objectAtIndex:4] subviews] objectAtIndex:1] subviews] lastObject]subviews]objectAtIndex:3];
//            }
//            
//        }
//        else
//        {
//            Upbut=(UIButton *) [[[[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] objectAtIndex:0] subviews] objectAtIndex:0] subviews] objectAtIndex:3] subviews] objectAtIndex:0] subviews] objectAtIndex:1];
//            
//            Nextbut=(UIButton *)[[[[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] objectAtIndex:0] subviews] objectAtIndex:0] subviews] objectAtIndex:3] subviews] objectAtIndex:0] subviews] objectAtIndex:2];
//            
//        }
//        
//    }
    
    [Upbut addTarget:self action:@selector(UpPageButtonSelector) forControlEvents:UIControlEventTouchDown];
    [Nextbut addTarget:self action:@selector(NextPageButtonSelector) forControlEvents:UIControlEventTouchDown];
    
    hintView=[[myhintView alloc] init];
    hintView.hidden=YES;
    hintView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    hintView.frame=CGRectMake(0, 0, 140, 140);
    hintView.center=self.view.center;
//    
//    if ([GlobalData GetInstance].GB_ProductVesion != Hyundai_Version)
//    {
//        [self.view addSubview:hintView];
//    }
}
#if 0

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch=[touches anyObject];
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    CGPoint moviePoint=CGPointMake(previousPoint.x-startPoint.x, previousPoint.y-startPoint.y);
    
    if (moviePoint.x/moviePoint.y<0.3 && moviePoint.x/moviePoint.y>-0.3)
    {
        hintView.hidden=NO;
        
        if (PanStartLocation==volumStart)
        {
            MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];//音量控制
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
            
            hintView.types=volumType;
            [hintView tinkerUp:volume With:0.0];
        }
        else if (PanStartLocation==lightSrart)
        {
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
            
            hintView.types=lightType;
            [hintView tinkerUp:light With:0.0];
        }
        
    }
    else if (moviePoint.x/moviePoint.y>4.0 || moviePoint.x/moviePoint.y<-4.0)
    {
        hintView.hidden=NO;
        
        PanStartLocation=progressStart;
        if (moviePoint.x>0.0)
        {
            hintView.types=progressTypeForwad;
        }
        else
        {
            hintView.types=progressTypeBackwad;
        }
        [hintView tinkerUp:moviePoint.x/1000+playingTime With:[GlobalData GetInstance].NewmoviePlayer.duration];
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch=[touches anyObject];
    startPoint = [touch previousLocationInView:self.view];//获取点击的位置
    if (startPoint.x>self.view.frame.size.width/2)
    {
        MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];//音量控制
        startVolum=musicPlayer.volume;
        PanStartLocation=volumStart;
    }
    else if (startPoint.x<=self.view.frame.size.width/2)
    {
        startLight=[UIScreen mainScreen].brightness;
        PanStartLocation=lightSrart;
    }
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    hintView.hidden=YES;
    
    playingTime=[GlobalData GetInstance].NewmoviePlayer.currentPlaybackTime;
    CGFloat allTime=[GlobalData GetInstance].NewmoviePlayer.duration;
    UITouch* touch=[touches anyObject];
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    CGPoint moviePoint=CGPointMake(previousPoint.x-startPoint.x, previousPoint.y-startPoint.y);
    if (PanStartLocation==progressStart)
    {
        if (currentDeviceModel==iPadModel)
        {
            playingTime=allTime*moviePoint.x/1000+playingTime;
        }
        else
        {
            playingTime=allTime*moviePoint.x/500+playingTime;
        }
        
        if (playingTime>allTime)
        {
            playingTime=allTime;
        }
        else if (playingTime<0.0f)
        {
            playingTime=0.0f;
        }
        [[GlobalData GetInstance].NewmoviePlayer setCurrentPlaybackTime:playingTime];
    }
    
}


#else
#endif

-(void)moviePlayerSetContentUrl{
    
}
//{
//    GB_time=0;//每次开始播放，播放时间置0
//    self.playTopView.hidden=NO;
//    NSDictionary *dic = [self.myMPArr objectAtIndex:self.myIndex];
//    NSString *url = [dic objectForKey:@"url"];
//    NSArray *tmpArr = [url componentsSeparatedByString:@"."];
//    //文件类型
//    NSString *fileType = [[tmpArr lastObject] lowercaseString];
//    
//    if ([fileType isEqualToString:@"mp3"] || [fileType isEqualToString:@"MP3"]) {
//        int location = [url length] - 3;
//        NSRange range;
//        range.location = location;
//        range.length = 3;
//        NSString *tmpUrl = [url stringByReplacingCharactersInRange:range withString:@"lrc"];
//        
//        Mp3View *mp3View = [[Mp3View alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//        mp3View.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
//        mp3View.PlayerC = [GlobalData GetInstance].NewmoviePlayer;
//        [[GlobalData GetInstance].NewmoviePlayer.view addSubview:mp3View];
//        [mp3View InitLRC:tmpUrl];
//        
//        //            UIView *view = [[[[[[[[[GlobalData GetInstance].NewmoviePlayer.view subviews] firstObject] subviews] firstObject] subviews] firstObject] subviews] firstObject];
//        //            UIImageView *img = [[UIImageView alloc] initWithFrame:mp3View.bounds];
//        //            img.image = [UIImage imageNamed:@"mp3_bg.png"];
//        //            [view addSubview:img];
//        
//        //   [GlobalData GetInstance].GB_Mp3BGImage = img;
//        [GlobalData GetInstance].GB_Mp3BGImage.hidden = NO;
//        
//    }
//    
//    NSString* encodedString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将网址含有的中文、空格等转化
//    [[GlobalData GetInstance].NewmoviePlayer setContentURL:[NSURL URLWithString:encodedString]];
//    [[GlobalData GetInstance].NewmoviePlayer  prepareToPlay];
//    [GlobalData GetInstance].NewmoviePlayer.useApplicationAudioSession=NO;
//    
//    [self performSelector:@selector(movieTimedOut) withObject:nil afterDelay:30.f];
//    
//    
//    
//}
-(void)movieTimedOut
{
    self.playTopView.hidden=YES;
}
-(void)moviePlayerPreparedToPlay:(NSNotification*)notification{
    
}
//{
//    isClickedBtn=NO;
//    //获得上次播放时间
//    LocalDataBase *userCourseChapterTb001=[LocalDataBase GetTableWithType:@"user_icr_rco" HasUser:NO];
//    NSDictionary *chapterDic=[self.myMPArr objectAtIndex:self.myIndex];
//    NSDictionary *userCourseChapterDic = [userCourseChapterTb001 GetOneRecordWithKeys:[NSArray arrayWithObjects:@"courseId",@"userid",@"chapterId", nil] Values:[NSArray arrayWithObjects:self.myCourseID,[GlobalData GetInstance].GB_UserID,[chapterDic objectForKey:@"chapterId"] , nil] UseUser:NO];
//    playingTime=0;
//    if (userCourseChapterDic!=nil)
//    {
//        playingTime=[[userCourseChapterDic objectForKey:@"playTime"] floatValue];
//    }
//    if (playingTime !=playingTime)
//    {
//        playingTime=0.0f;
//    }
//    self.playTopView.hidden=YES;
//    
//    //    playingTime=40.0f
//    
//    [[GlobalData GetInstance].NewmoviePlayer setCurrentPlaybackTime:playingTime];
//    //    [[GlobalData GetInstance].NewmoviePlayer play];
//}

-(void)moviePlayerBackDidFinish:(NSNotification *)notification{
    
}
//{
//    self.playTopView.hidden=YES;
//    Gb_UserGoBack=NO;
//    
//    NSNumber *reason = [notification.userInfo valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
//    if(reason !=nil)
//    {
//        NSInteger reasonAsInteger = [reason integerValue];
//        switch (reasonAsInteger)
//        {
//            case MPMovieFinishReasonPlaybackEnded:
//            {
//                playingTime=0.0f;
//                [self StopTimer];
//                
//                if (isClickedBtn)//点击按钮
//                {
//                    isClickedBtn=NO;
//                    return;
//                }
//                if (self.myIndex<[self.myMPArr count]-1 && [self.myMPArr count]>1)//自动进入下一首
//                {
//                    [self nextPage];
//                    return;
//                }
//                break;
//            }
//            case MPMovieFinishReasonPlaybackError:
//            {
//                [self StopTimer];
//                break;
//            }
//            case MPMovieFinishReasonUserExited:
//            {
//                playingTime=[GlobalData GetInstance].NewmoviePlayer.currentPlaybackTime;
//                [self StopTimer];
//                break;
//            }
//            default:
//                break;
//        }
//        
//    }
//    
//    [self StopTimer];
//    Gb_UserGoBack=YES;
//    [self SaveLearnRecords];
//    
//    
//    //    if (GB_time >= 1.0)
//    //    {
//    //        isplayed = YES;
//    //    }
//    //
//    //    if (isplayed == NO)
//    //    {
//    //
//    //        NSLog(@"---GB_time==%d",GB_time);
//    //
//    //        if (self.isLocalPlay)
//    //        {
//    //            [GlobalFunc ShowNormalAlert:@"学习时间过短或发生异常，可重试一次！"];
//    //            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    //            [delegate ReInitLocalServer];
//    //        }
//    //        else
//    //        {
//    //            [GlobalFunc ShowNormalAlert:@"学习时间过短，或播放时发生异常，此次学习记录不提交！"];
//    //        }
//    //
//    //        if (self.myMoviePlayer.moviePlayer.fullscreen)
//    //        {
//    //            //据说能防止退不出的情况
//    //            self.myMoviePlayer.moviePlayer.fullscreen = NO;
//    //        }
//    //        else if (self.myMoviePlayer.moviePlayer.fullscreen==NO)
//    //        {
//    //        }
//    //
//    //        [self.delegate moviePlayerViewCtrlDismiss:NO AndLearnDic:nil];
//    //        [self performSelector:@selector(removeObserverFun) withObject:nil afterDelay:0];
//    //        return;
//    //    }
//    //
//    //    NSInteger reasonAsInteger = [reason integerValue];
//    //    if (reasonAsInteger==MPMovieFinishReasonPlaybackError)
//    //    {
//    //    }
//    //    else
//    //    {
//    //        [self InsertuserCourseChapterInfo];//（保存播放点）
//    //        if (GB_OffLineLogin || GB_UseNetType == CanUse_No)
//    //        {
//    //            //保存离线学习进度
//    //            [self InsertOfflineLearnInfo];//（保存学习情况）
//    //            //离线时保存在本地，在线直接回传
//    //            if (GB_OffLineLogin)
//    //            {
//    //                [GlobalFunc ShowNormalAlert:@"学习记录已经保存在本地，下次在线登录成功后，数据将提交到服务器！"];
//    //            }
//    //        }
//    //        [self.delegate moviePlayerViewCtrlDismiss:YES AndLearnDic:nil];
//    //    }
//    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

-(void)removeObserverFun{
    
}
//{
//    [[GlobalData GetInstance].NewmoviePlayer setContentURL:[NSURL URLWithString:@""]];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self StopThread];
//    
//}
//方法类型：系统方法
//方法功能：缓冲结束时调用该方法
-(void)moviePlayerBackDidChanged{
    
}
//{
//    MPMoviePlaybackState playState = [GlobalData GetInstance].NewmoviePlayer.playbackState;
//    if (playState == MPMoviePlaybackStateStopped)//停止
//    {
//        [self StopTimer];
//    }
//    else if(playState == MPMoviePlaybackStatePlaying)//播放
//    {
//        [self performSelectorOnMainThread:@selector(BeginTimer) withObject:nil waitUntilDone:NO];
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(movieTimedOut) object:nil];
//    }
//    else if(playState == MPMoviePlaybackStatePaused)//暂停
//    {
//        [self StopTimer];
//    }
//    else if(playState == MPMoviePlaybackStateInterrupted)//中断（来电）
//    {
//        [self StopTimer];
//    }
//    else if(playState == MPMoviePlaybackStateSeekingForward)//向前
//    {
//        [self StopTimer];
//    }
//    else if(playState == MPMoviePlaybackStateSeekingBackward)//向后
//    {
//        [self StopTimer];
//    }
//    LOG_CMETHODBEGIN;
//}

-(void)nextPage
{
//    [self SaveLearnRecords];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 6.0)
    {
//        [GlobalFunc ShowNormalAlert:@"iOS 6.0以下设备不支持循环播放"];
        return ;
    }
    if(self.myIndex>=self.myMPArr.count-1)
    {
//        [self AddStatusLabelWithText:@"已经是最后一个视频了"];
        return ;
    }
    self.myIndex ++;
    [self moviePlayerSetContentUrl];
    
}
-(void)UpPageButtonSelector//上一个
{
    isClickedBtn=YES;
//    [self SaveLearnRecords];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 6.0)
    {
//        [GlobalFunc ShowNormalAlert:@"iOS 6.0以下设备不支持循环播放"];
        return ;
    }
    if(self.myIndex==0)
    {
        [self moviePlayerSetContentUrl];
//        [self AddStatusLabelWithText:@"已经是第一个了"];
        return ;
    }
    self.myIndex--;
    [self moviePlayerSetContentUrl];
    
}
-(void)NextPageButtonSelector//下一个
{
    isClickedBtn=YES;
    
//    [self SaveLearnRecords];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 6.0)
    {
//        [GlobalFunc ShowNormalAlert:@"iOS 6.0以下设备不支持循环播放"];
        return ;
    }
    if(self.myIndex>=self.myMPArr.count-1)
    {
//        [self AddStatusLabelWithText:@"已经是最后一个了"];
        [self moviePlayerSetContentUrl];
        return ;
    }
    self.myIndex ++;
    [self moviePlayerSetContentUrl];
}
//启动计时器
-(void) BeginTimer{
    
    [myTimer invalidate];
    myTimer=nil;
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(Timing) userInfo:nil repeats:YES];
    [myTimer fire];
    
}

//停止计时器
-(void) StopTimer
{
    [myTimer invalidate];
    myTimer = nil;
}

//计时
-(void) Timing
{
//    GB_time++;
}


-(void)SaveLearnRecordsz{
    
}
//{
//    GB_CanCrossView = VerticalSupportOnly;
//    playingTime=[GlobalData GetInstance].NewmoviePlayer.currentPlaybackTime;
//    
//    if (playingTime>= [GlobalData GetInstance].NewmoviePlayer.duration - 1)
//    {
//        playingTime=0.0f;
//    }
//    [self InsertuserCourseChapterInfo];//（保存播放点）
//    
//    if (GB_OffLineLogin || GB_UseNetType == CanUse_No)
//        //    if (1)
//    {
//        //保存离线学习进度
//        [self InsertOfflineLearnInfo];//（保存学习情况）
//        //            [self performSelectorInBackground:@selector(InsertOfflineLearnInfo) withObject:nil];
//        //离线时保存在本地，在线直接回传
//        if (GB_OffLineLogin)
//        {
//#if ISMobile_Version
//            [self AddStatusLabelWithText:@"学习记录已保存在本地，下次登录时将重新提交"];
//#else
//            [self AddStatusLabelWithText:@"学习记录已经保存在本地，下次在线登录成功后，数据将提交到服务器！"];
//#endif
//            
//        }
//        
//        if (Gb_UserGoBack)
//        {
//            [self.delegate moviePlayerViewCtrlDismiss:NO AndLearnDic:nil];
//        }
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
//    }
//    
//}

-(void)uploadLearnProgressWithDic:(NSDictionary *)dic
{
//    [self.delegate UploadLearnProgressWithLearnDic:dic];
    //    [self.delegate moviePlayerViewCtrlDismiss:YES AndLearnDic:dic];
    //    -(void)moviePlayerViewCtrlDismiss:(BOOL)isSucces AndLearnDic:(NSDictionary *)dic
    
}


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
//    [userCourseChapterTb InsertDataWithDic:userCourseChapterDic Replace:YES];
}

//插入用户离线学习数据表
- (void)InsertOfflineLearnInfo{
    
}
//{
//    //学习情况表
//    learnTb = [LocalDataBase GetTableWithType:@"cst_performance" HasUser:NO];
//    NSDictionary *offlearnDic=[learnTb GetOneRecordWithKeys:[NSArray arrayWithObjects:@"userid",@"courseId",@"chapterId", nil] Values:[NSArray arrayWithObjects:[GlobalData GetInstance].GB_UserID,self.myCourseID,[[GlobalData GetInstance].GB_PlayerDic objectForKey:@"chapterId"], nil] UseUser:NO];
//    NSDictionary *chapterDic=[self.myMPArr objectAtIndex:self.myIndex];
//    
//    if (self.myCourseDic != nil)//有这条课程记录
//    {
//        NSMutableDictionary *learnDic = [NSMutableDictionary dictionaryWithCapacity:12];
//        
//        [learnDic setValue:[GlobalData GetInstance].GB_UserID forKey:@"userid"];
//        [learnDic setValue:self.myCourseID forKey:@"courseId"];
//        [learnDic setValue:[chapterDic objectForKey:@"chapterId"] forKey:@"chapterId"];
//        [learnDic setValue:[self.myCourseDic objectForKey:@"classroomid"] forKey:@"classroomid"];
//        if (GB_OffLineLogin) {
//            [learnDic setValue:[self.myCourseDic objectForKey:@"classroomid"] forKey:@"tbcId"];
//        }
//        else{
//            [learnDic setValue:[self.myCourseDetailDic objectForKey:@"classroomid"] forKey:@"tbcId"];
//        }
//        [learnDic setValue:@"" forKey:@"suspendData"];
//        [learnDic setValue:@"" forKey:@"location"];
//        [learnDic setValue:@"0" forKey:@"grade"];
//        [learnDic setValue:[chapterDic objectForKey:@"type"] forKey:@"status"];
//        
//        
//        if (offlearnDic!=nil) {//已有学习记录，累加时间和学习次数
//            float time=[[offlearnDic objectForKey:@"time"] floatValue];
//            [learnDic setValue:[GlobalFunc GetStrFromFloat:GB_time+time] forKey:@"time"];
//            int ltimes = [[offlearnDic objectForKey:@"offltimes"] intValue];
//            [learnDic setValue:[NSString stringWithFormat:@"%d",ltimes+1] forKey:@"offltimes"];
//        }
//        else
//        {
//            [learnDic setValue:[GlobalFunc GetStrFromFloat:GB_time] forKey:@"time"];
//            [learnDic setValue:@"1" forKey:@"offltimes"];
//        }
//        
//        
//        
//        [learnDic setValue:[GlobalFunc GetStrFromInt:[GlobalData GetInstance].NewmoviePlayer.currentPlaybackTime] forKey:@"timestamp"];
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
//        //把数据插入表中
//        [learnTb InsertDataWithDic:learnDic Replace:YES];
//    }
//    
//}
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
//{
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



//-(void)deviceOrientationDidChange:(NSNotification *)nofi
//{
//    self.playTopView.frame=self.view.frame;
//}
- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

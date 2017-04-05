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
//播放控制器
@property (nonatomic, strong) MobilePlayerViewContrl *moviePlayerCtrl;

//未播放时的背景图片//播放按钮视图（最好自己封装一个View）
@property (nonatomic, strong) UIImageView *backImageView;


@property (nonatomic, strong) NSDictionary *urlDic;
//@property (nonatomic, strong) NSMutableArray *myDataArr;
@end

@implementation PlayerViewController

//- (NSMutableArray *)myDataArr{
//    if (!_myDataArr) {
//        _myDataArr = [[NSMutableArray alloc] init];
//    }
//    return _myDataArr;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MediaPlayer播放";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RotationClicked) name:@"888888" object:nil];

    //初始化未播放时的界面
    [self initView];
}

////在需要旋转的界面中写方法
//- (void)viewWillAppear:(BOOL)animated{
//    [self interfaceOrientation:UIInterfaceOrientationLandscapeLeft];
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    [self interfaceOrientation:UIInterfaceOrientationPortrait];
//}
//
//- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
//{
//    //强制转换
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = orientation;
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
//}

- (void)initView{
    //背景图片
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width*9/16)];
    self.backImageView.userInteractionEnabled = YES;
    self.backImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backImageView];
    
    NSURL *imageUrl = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1491214025476&di=e366ae73a26c02deb8b9ee93c63cca7b&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%253D580%2Fsign%3Defe9a6aa0e55b3199cf9827d73a88286%2F537a84d6277f9e2f4722f7a31b30e924b999f37c.jpg"];
    [self.backImageView sd_setImageWithURL:imageUrl];
    
    /*毛玻璃效果*/
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*9/16);
    [self.backImageView addSubview:effectView];
    
    //播放按钮
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(self.backImageView.frame.size.width/2-50, self.backImageView.frame.size.height/2-50, 100, 100);
    [playBtn setImage:[UIImage imageNamed:@"button_playermini"] forState:UIControlStateNormal];
//    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    playBtn.backgroundColor = [UIColor clearColor];
    [playBtn addTarget:self action:@selector(playBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backImageView addSubview:playBtn];
}

#pragma mark - 播放按钮点击事件
- (void)playBtnAction{
    //初始化视频播放器
    [self addMoviePlayer];
    
    NSString *fileName = [NSString stringWithFormat:@"%@",self.downloadModel.title];
    NSString *filePath = [NSString stringWithFormat:@"%@",self.downloadModel.targetPath];
    NSLog(@"%@的文件路径为%@",fileName,filePath);
    if (_isLocalPlayer) {
//        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
//        self.urlDic = [NSDictionary dictionaryWithObject:fullPath forKey:@"myURL"];

        self.urlDic = [NSDictionary dictionaryWithObject:filePath forKey:@"myURL"];
        NSLog(@"%@的本地路径为%@",fileName,filePath);
    }else{
        self.urlDic = [NSDictionary dictionaryWithObject:self.downloadModel.savePath forKey:@"myURL"];
        NSLog(@"%@的网络路径为%@",fileName,self.downloadModel.savePath);
    }


    //发送URL
    NSURL *url = [NSURL URLWithString:filePath];
    [self playMoviePlayerWithUrl:url];
}

#pragma mark - 初始化视频播放器并发送URL
- (void)addMoviePlayer{
    self.moviePlayerCtrl = [[MobilePlayerViewContrl alloc] init];
    self.moviePlayerCtrl.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width*9/16);
    //    self.moviePlayerCtrl.delegate=self;
    self.moviePlayerCtrl.myMoviePlayer.moviePlayer.allowsAirPlay = YES;
    [self.moviePlayerCtrl.myMoviePlayer.moviePlayer setShouldAutoplay:NO];
    
    //等待界面和Logo
    self.moviePlayerCtrl.playTopView.frame=CGRectMake(0, 0, self.moviePlayerCtrl.view.frame.size.width, self.moviePlayerCtrl.view.frame.size.height);
    self.moviePlayerCtrl.playLoadImgView.frame=CGRectMake(self.moviePlayerCtrl.view.frame.size.width/2-424/8, self.moviePlayerCtrl.view.frame.size.height/2-310/8, 424/4, 310/4);
    //控制界面（透明）
    self.moviePlayerCtrl.myMovieControlsView.frame= CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*9/16);
    
    
    [self addChildViewController:self.moviePlayerCtrl];
    [self.view addSubview:self.moviePlayerCtrl.view];
    
    //    moviePlayerCtrl.myMoviePlayer.moviePlayer.controlStyle=MPMovieControlStyleNone;
}

-(void)playMoviePlayerWithUrl:(NSURL *)movieUrl{
    //隐藏蒙版
    self.backImageView.hidden=YES;
    //显示播放器
    self.moviePlayerCtrl.view.hidden=NO;
//    self.moviePlayerCtrl.myIndex=myIndex;
    //视频URL
    self.moviePlayerCtrl.myCourseDic = self.urlDic;
    //是否本地播放（必传）
    self.moviePlayerCtrl.isLocalPlay = self.isLocalPlayer;
//    self.moviePlayerCtrl.myMovieArray=self.chapterArr;
    //调用播放方法
    [self.moviePlayerCtrl Play];
}




#pragma mark 屏幕旋转
-(void)RotationClicked{
    
    BOOL isVertical = NO;//竖屏
    
    if (GB_CanCrossView == VerticalSupportOnly) {
        GB_CanCrossView = CrossSupportOnly;
        isVertical = YES;//横屏
    }else{
        GB_CanCrossView = VerticalSupportOnly;
    }
    
    
    if (isVertical)
    {
        //横屏
//        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];//这句话是防止手动先把设备置为横屏,导致下面的语句失效.
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
//        self.navigationController.view.bounds = CGRectMake(self.navigationController.view.bounds.origin.x, self.navigationController.view.bounds.origin.y, self.view.frame.size.height, self.view.frame.size.width);

        [self isHorizontalUpDate];
        self.navigationController.navigationBar.hidden = YES;

    }
    else
    {
        //横屏点击按钮, 旋转到竖屏
//        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];//这句话是防止手动先把设备置为竖屏,导致下面的语句失效.
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
//        self.navigationController.view.bounds = CGRectMake(self.navigationController.view.bounds.origin.x, self.navigationController.view.bounds.origin.y, self.view.frame.size.height, self.view.frame.size.width);
        [self notHorizontalUpDate];
        self.navigationController.navigationBar.hidden = NO;

    }

    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<8.0){
        
        // 状态栏动画持续时间
        CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
        [UIView animateWithDuration:duration animations:^{
            //修改状态栏的方向及view的方向进而强制旋转屏幕
            [[UIApplication sharedApplication] setStatusBarOrientation:isVertical?UIInterfaceOrientationLandscapeRight:UIInterfaceOrientationPortrait];
            
            self.navigationController.view.transform =isVertical? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformIdentity;
        }];


        
//        if (GB_CanCrossView == CrossSupportOnly)
//        {
//            if (GB_SDK_Version<7.0)
//            {
//                self.navigationController.view.bounds = CGRectMake(self.navigationController.view.bounds.origin.x, self.navigationController.view.bounds.origin.y, 480,320);
//            }
//            else
//            {
//                self.navigationController.view.bounds = CGRectMake(self.navigationController.view.bounds.origin.x, self.navigationController.view.bounds.origin.y, self.view.frame.size.height, self.view.frame.size.width);
//            }
//            [self isHorizontalUpDate];
//        }
//        else
//        {
//            if (GB_SDK_Version<7.0)
//            {
//                self.navigationController.view.bounds = CGRectMake(self.navigationController.view.bounds.origin.x, self.navigationController.view.bounds.origin.y, 320,480);
//            }
//            else
//            {
//                self.navigationController.view.bounds = CGRectMake(self.navigationController.view.bounds.origin.x, self.navigationController.view.bounds.origin.y, self.view.frame.size.height, self.view.frame.size.width);
//            }
//            
//            [self notHorizontalUpDate];
//        }
    }
    else
    {
        
//        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];//这句话是防止手动先把设备置为横屏,导致下面的语句失效.
//        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
//        
//        [self isHorizontalUpDate];

    }
}


-(void)isHorizontalUpDate//横屏时
{
    
//    IsPortrait = NO;
    self.moviePlayerCtrl.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.moviePlayerCtrl.playTopView.frame=CGRectMake(0, 0, self.moviePlayerCtrl.view.frame.size.width, self.moviePlayerCtrl.view.frame.size.height);
    self.moviePlayerCtrl.playLoadImgView.frame=CGRectMake(self.moviePlayerCtrl.view.frame.size.width/2-310/6, self.moviePlayerCtrl.view.frame.size.height/2-424/6, 310/3, 424/3);
    
    self.backImageView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    homeScrollView.hidden=YES;
//    self.myTopBar.hidden=YES;
//    seplineView1.hidden=YES;
//    seplineView2.hidden=YES;
    self.moviePlayerCtrl.myMovieControlsView.isHorizontal=YES;
    if (self.backImageView.hidden==NO){
//        [self.topBackView UPdateFrame];
    }
    self.moviePlayerCtrl.myCourseBackView.frame=CGRectMake(self.moviePlayerCtrl.view.frame.size.width-272, 0, 272,self.view.frame.size.height);
    [self.moviePlayerCtrl.myCourseTableView UpdateFrame];
    
    //刷新控件布局
    self.moviePlayerCtrl.myMovieControlsView.frame=CGRectMake(0, 0, self.moviePlayerCtrl.view.frame.size.width, self.moviePlayerCtrl.view.frame.size.height);
    [self.moviePlayerCtrl.myMovieControlsView UpdateFrame];
    self.moviePlayerCtrl.hintView.frame=CGRectMake(self.view.frame.size.width/2-70, self.view.frame.size.height/2-70,140,140);
}

-(void)notHorizontalUpDate//竖屏时
{
    //控制器frame
    self.moviePlayerCtrl.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width*9/16);
    
    //等待标志视图
    self.moviePlayerCtrl.playTopView.frame=CGRectMake(0, 0, self.moviePlayerCtrl.view.frame.size.width, self.moviePlayerCtrl.view.frame.size.height);
    self.moviePlayerCtrl.playLoadImgView.frame=CGRectMake(self.moviePlayerCtrl.view.frame.size.width/2-310/8, self.moviePlayerCtrl.view.frame.size.height/2-424/8, 310/4, 424/4);
    
    //播放按钮视图
    self.backImageView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*9/16);
    
//    homeScrollView.hidden=NO;
//    self.myTopBar.hidden=NO;
//    seplineView1.hidden=NO;
//    seplineView2.hidden=NO;
    self.moviePlayerCtrl.myCourseBackView.hidden=YES;
    
    if (self.backImageView.hidden==NO){
//        [self.moviePlayerCtrl.topBackView UPdateFrame];
    }
    
    //播放器控件视图
    self.moviePlayerCtrl.myMovieControlsView.frame=CGRectMake(0, 0, self.moviePlayerCtrl.view.frame.size.width, self.moviePlayerCtrl.view.frame.size.height);
    self.moviePlayerCtrl.myMovieControlsView.isHorizontal=NO;
    //刷新控件视图上控件的frame
    [self.moviePlayerCtrl.myMovieControlsView UpdateFrame];
    
    //触屏提示
    self.moviePlayerCtrl.hintView.frame=CGRectMake(self.view.frame.size.width/2-70, self.view.frame.size.height/2-70,140,140);
    
//    [self.myTableView reloadData];

}



- (void)dealloc{
    
    [self.moviePlayerCtrl removeThisView];
    [self.moviePlayerCtrl removeFromParentViewController];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

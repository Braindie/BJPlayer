//
//  PlayerViewController.m
//  BJPlayer
//
//  Created by zhangwenjun on 16/11/9.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import "PlayerViewController.h"
#import "MobilePlayerViewContrl.h"

@interface PlayerViewController ()
@property (nonatomic, strong) MobilePlayerViewContrl *moviePlayerCtrl;
@property (nonatomic, strong) UIView *topBackView;//播放按钮视图（最好自己封装一个View）
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
    self.title = @"视频播放页面";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RotationClicked) name:@"888888" object:nil];

    [self initView];
}
- (void)dealloc{
    
    [self.moviePlayerCtrl removeThisView];
    [self.moviePlayerCtrl removeFromParentViewController];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initView{

    //包含播放按钮的视图
    self.topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width*9/16)];
    self.topBackView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.topBackView];
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(self.topBackView.frame.size.width/2-50, 50, 100, 30);
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    playBtn.backgroundColor = [UIColor lightGrayColor];
    [playBtn addTarget:self action:@selector(playBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.topBackView addSubview:playBtn];
    
    
}

- (void)playBtnClicked{
    //点击播放按钮后加载播放器
    [self AddMoviePlayer];
    
    NSString *fileName = [NSString stringWithFormat:@"%@",self.downLoadModel.title];
    NSString *filePath = [NSString stringWithFormat:@"%@",self.downLoadModel.targetPath];
    
    NSLog(@"%@的文件路径为%@",fileName,filePath);
    self.urlDic = [NSDictionary dictionaryWithObject:self.downLoadModel.filePath forKey:@"myURL"];
    
    NSURL *url = [NSURL URLWithString:filePath];
    [self playMoviePlayerWithUrl:url];
}

//创建视频播放器
-(void)playMoviePlayerWithUrl:(NSURL *)movieUrl{
    
    self.topBackView.hidden=YES;
    self.moviePlayerCtrl.view.hidden=NO;
//    self.moviePlayerCtrl.myIndex=myIndex;
    self.moviePlayerCtrl.myCourseDic = self.urlDic;
    self.moviePlayerCtrl.isLocalPlay=YES;//本地播放
//    self.moviePlayerCtrl.myMovieArray=self.chapterArr;
    [self.moviePlayerCtrl Play];
}


- (void)AddMoviePlayer{
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
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];//这句话是防止手动先把设备置为横屏,导致下面的语句失效.
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
//        self.navigationController.view.bounds = CGRectMake(self.navigationController.view.bounds.origin.x, self.navigationController.view.bounds.origin.y, self.view.frame.size.height, self.view.frame.size.width);

        [self isHorizontalUpDate];
    }
    else
    {
        //横屏点击按钮, 旋转到竖屏
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];//这句话是防止手动先把设备置为竖屏,导致下面的语句失效.
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
//        self.navigationController.view.bounds = CGRectMake(self.navigationController.view.bounds.origin.x, self.navigationController.view.bounds.origin.y, self.view.frame.size.height, self.view.frame.size.width);
        [self notHorizontalUpDate];
    }

    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<8.0){
        
        // 状态栏动画持续时间
        CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
        [UIView animateWithDuration:duration animations:^{
            //修改状态栏的方向及view的方向进而强制旋转屏幕
            [[UIApplication sharedApplication] setStatusBarOrientation:isVertical?UIInterfaceOrientationLandscapeRight:UIInterfaceOrientationPortrait];
            
            self.navigationController.view.transform =isVertical? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformIdentity;
        }];
        self.navigationController.view.bounds = CGRectMake(self.navigationController.view.bounds.origin.x, self.navigationController.view.bounds.origin.y, self.view.frame.size.height, self.view.frame.size.width);
//        self.navigationController.view.bounds = CGRectMake(self.navigationController.view.bounds.origin.x, self.navigationController.view.bounds.origin.y, 480,320);


        
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
    
    self.topBackView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    homeScrollView.hidden=YES;
//    self.myTopBar.hidden=YES;
//    seplineView1.hidden=YES;
//    seplineView2.hidden=YES;
    self.moviePlayerCtrl.myMovieControlsView.isHorizontal=YES;
    if (self.topBackView.hidden==NO){
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
    self.topBackView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*9/16);
    
//    homeScrollView.hidden=NO;
//    self.myTopBar.hidden=NO;
//    seplineView1.hidden=NO;
//    seplineView2.hidden=NO;
    self.moviePlayerCtrl.myCourseBackView.hidden=YES;
    
    if (self.topBackView.hidden==NO){
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

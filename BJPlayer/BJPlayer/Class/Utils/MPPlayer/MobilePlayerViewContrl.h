//
//  MobilePlayerViewContrl.h
//  MobileStudy
//
//  Created by zhangwenjun on 14/12/10.
//
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
//#import "MBProgressHUD.h"
//#import "NSData+Base64.h"
//#import "Base64Data.h"
//#import "NSString+Digest.h"
//#import "UIView+Hierarchy.h"
//#import "LocalDataBase.h"
//#import "Base64+DES.h"
#import <MobileCoreServices/MobileCoreServices.h>
//#import "NetRequest.h"
//#import "UIImageView+WebCache.h"
#import "AMProgressView.h"
//#import "CommonData.h"
#import "MovieControlsView.h"
#import "CourseTableViewContrl.h"
//#import "mobileMPMoviePlayerContrl.h"
#import "myhintView.h"


#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]




@interface MobilePlayerViewContrl : UIViewController<MovieControlsDelegate,courseTableDelegate>{
    NSTimer *myTimer;
    NSTimer *myProgressTimer;
    float playingTime;//播放时间（断点）
    //7.插入用户课程章节表
//    LocalDataBase *userCourseChapterTb;
//    LocalDataBase *learnTb;
//    LocalDataBase * chapterTb;
//    LocalDataBase * courseTb;
    
    BOOL isMP4file;//是否MP4文件
    BOOL isTouches;
    CGPoint startPoint;//接触开始的点
    CGFloat startVolum;//接触开始的音量
    CGFloat startLight;//接触开始的亮度
    
    BOOL isPlaying;//是否正在播放
    
    NSInteger showErrTimes;
    

    BOOL hasNeverPlayed;//从来没有播放过
    BOOL isToPlay;//是否正在播放
    
    
    BOOL isplayed;//视频是否播放；
    
    //触摸屏幕时使用
    BOOL istouched;//收放状态栏
    int touchTime;//7秒钟之后自动隐藏

}
//是否是本地视频
@property (nonatomic, assign) BOOL isLocalPlay;

//视频播放控制器
@property (nonatomic, strong) MPMoviePlayerViewController *myMoviePlayer;

#pragma mark - 菊花和Gif图二选一
@property (nonatomic, strong) UIView *playTopView;//等待标志的背景图
@property (nonatomic, strong) UIImageView* playLoadImgView;//等待标志(可以是Gif图）
@property (nonatomic, strong) UIActivityIndicatorView *zhuanView;//菊花转

//进度、音量、亮度提示
@property(nonatomic,strong)myhintView * hintView;//声音、亮度提示
//播放控件视图
@property (nonatomic,strong) MovieControlsView *myMovieControlsView;
//
@property(nonatomic,strong) UIView *myCourseBackView;
////按钮图
@property(nonatomic, strong)UIView *topView;

//视频URL
@property(nonatomic,strong)NSDictionary *myCourseDic;




//@property(nonatomic, weak) id<MyCourseDetailMovieDelegate> delegate;//回传进度
@property(nonatomic,strong)NSMutableArray *myMovieArray;
@property(nonatomic,strong)NSMutableArray *myMPArr;//包含的视频、音频
//@property(nonatomic,strong)NSDictionary *myCourseDetailDic;
@property(nonatomic,strong)NSURL *movieUrl;
@property(nonatomic,strong)NSString *myCourseID;
@property(nonatomic,strong)NSString *myChapterID;
@property(nonatomic,strong)NSString *classroomID;
@property(nonatomic,assign) int myIndex;
@property (nonatomic,assign) BOOL isPrePlay;
@property(nonatomic,copy)NSString *chapterParentID;


//@property(nonatomic,assign)PlaySourseType  myPlaySourseType;



@property(nonatomic,strong)CourseTableViewContrl *myCourseTableView;

@property(nonatomic,assign) BOOL isSourseClick;
@property(nonatomic, strong)UIButton *mybackBtn;    //收起按钮

//外部调用播放事件
- (void) Play;


-(void)moviePlayerSetContentUrl;
-(void)getMovieMPArr;
-(void) StopTimer;
-(void)SaveLearnRecords;


-(void) removeThisView;

-(void) StopAndSaveLearnRecords;

@end

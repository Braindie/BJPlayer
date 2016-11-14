//
//  MyMoviePlayerViewController.h
//  MobileStudy
//
//  Created by chenxili on 14-9-14.
//
//

//#import "BaseViewCtrl.h"
#import <MediaPlayer/MediaPlayer.h>

//enum
//{
//    volumStart=0,
//    lightSrart,
//    progressStart
//    
//}PanStartLocation;
//
//enum
//{
//    iPadModel,
//    iPhoneOriPodModel
//}currentDeviceModel;

//@protocol MyCourseDetailMovieDelegate <NSObject>
//-(void)moviePlayerViewCtrlDismiss:(BOOL)isSucces AndLearnDic:(NSDictionary *)dic;
//-(void) UploadLearnProgressWithLearnDic:(NSDictionary *)dic;
//-(void)MovieUpdateTopView;
//-(void) reloadRowsCell:(int)index;
//
//@end


@class myhintView;
@interface MyMoviePlayerViewController : UIViewController
{
    
    BOOL isplayed;//视频是否播放；
    NSTimer *myTimer;
    float playingTime;//播放时间（断点）
    //7.插入用户课程章节表
//    LocalDataBase *userCourseChapterTb;
//    LocalDataBase *learnTb;
//    LocalDataBase * chapterTb;
//    LocalDataBase * courseTb;
    
    BOOL isMP4file;//是否MP4文件
    BOOL isClickedBtn;//是否点击前一首、后一首按钮
    BOOL isTouches;
    CGPoint startPoint;//接触开始的点
    CGFloat startVolum;//接触开始的音量
    CGFloat startLight;//接触开始的亮度
    myhintView * hintView;//声音、亮度提示
}

//@property(nonatomic, weak) id<MyCourseDetailMovieDelegate> delegate;//回传进度
@property(nonatomic,strong)NSMutableArray *myMovieArray;
@property(nonatomic,strong)NSMutableArray *myMPArr;//包含的视频、音频
@property(nonatomic,strong)NSDictionary *myCourseDic;
@property(nonatomic,strong)NSDictionary *myCourseDetailDic;
@property(nonatomic,copy)NSURL *movieUrl;
@property(nonatomic,copy)NSString *myCourseID;
@property(nonatomic,copy)NSString *myChapterID;
@property(nonatomic,copy)NSString *classroomID;
@property(nonatomic,assign) int myIndex;
@property(nonatomic,assign) BOOL isLocalPlay;
@property(nonatomic,copy)NSString *chapterParentID;
@property(nonatomic,strong)MPMoviePlayerViewController *myMoviePlayer;

@property(nonatomic,strong)UIImageView* playLoadImgView;//等待标志
@property(nonatomic,strong)UIView *playTopView;//等待标志的背景

-(void)moviePlayerSetContentUrl;
-(void)getMovieMPArr;

@end

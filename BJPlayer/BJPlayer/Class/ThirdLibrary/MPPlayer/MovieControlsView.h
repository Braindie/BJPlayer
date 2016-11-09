//
//  MovieControlsView.h
//  MobileStudy
//
//  Created by chenxili on 14/12/10.
//
//

#import <UIKit/UIKit.h>
#import "AMProgressView.h"


@protocol MovieControlsDelegate <NSObject>

//返回
-(void)backBtnClicked;
//播放
-(void)playBtnClicked;
//屏幕转换
-(void)screenSwitchBtnClicked;
//上一节
-(void)upBtnClicked;
//下一节
-(void)nextBtnClicked;
//收放课程列表
-(void)courseListBtnClicked;
//锁屏、解锁
-(void)lockBtnClicked;
//设置进度
-(void)ChangedValue:(float)value;

-(BOOL) IsPlaying;//是否正在播放还是暂停
-(BOOL) HasPlayed;//已经播放了

-(void) MakeSureIfShowMulu;

@end

@interface MovieControlsView : UIView

@property(nonatomic, weak) id<MovieControlsDelegate> delegate;//回传进度

@property(nonatomic,strong)UIImageView* playLoadImgView;//等待标志
@property(nonatomic,strong)UIView *playTopView;//等待标志的背景

@property(nonatomic,strong)UIView *topViewBar;//上部的浮出框
@property(nonatomic,strong)UIView *bottomViewBar;//下部的浮出框
@property(nonatomic,strong)UIButton *backBtn;//返回按钮
@property(nonatomic,strong)UILabel *titileLab;//上部显示视频名称的标签；
@property(nonatomic,strong)UILabel *timeLab;//播放时间段显示
@property(nonatomic,strong)UIButton *upBtn;//上一章节
@property(nonatomic,strong)UIButton *nextBtn;//下一章节
@property(nonatomic,strong)UIButton *playBtn;//播放、暂停按钮
@property(nonatomic,strong)UIButton *courseListBtn;//显示章节列表按钮
@property(nonatomic,strong)UIButton *lockBtn;//锁屏按钮；
//@property(nonatomic,strong)UISlider *progressBar;//进度条
@property(nonatomic,strong)UIButton *screenSwitchBtn;//屏幕大小转换
@property(nonatomic,assign) BOOL isHorizontal;//是否横屏
@property(nonatomic,strong) UIImageView *backProgressBar;
@property(nonatomic,strong) UIImageView *playProgressBar;
@property(nonatomic,strong) UIImageView *playableProgressBar;
@property(nonatomic,strong) UIButton *playerPoint;

@property(nonatomic,assign) float playValueprogress;
@property(nonatomic,assign) float playableValueprogress;

@property (nonatomic,assign) BOOL isFull;//是否为全屏
-(void)UpdateFrame;

//获取上方导航控件下面坐标值y
-(float) GetTopBottom;
//获取下方工具栏上方坐标值y
-(float) GetBottomTop;

@end

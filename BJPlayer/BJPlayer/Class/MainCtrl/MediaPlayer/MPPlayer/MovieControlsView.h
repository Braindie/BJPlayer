//
//  MovieControlsView.h
//  MobileStudy
//
//  Created by chenxili on 14/12/10.
//
//

#import <UIKit/UIKit.h>


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

@end




@interface MovieControlsView : UIView

//上部的浮出框
@property(nonatomic,strong)UIView *topViewBar;
//下部的浮出框
@property(nonatomic,strong)UIView *bottomViewBar;

@property(nonatomic,strong)UIButton *playBtn;//播放、暂停按钮

@property(nonatomic, weak) id<MovieControlsDelegate> delegate;//回传进度

@end

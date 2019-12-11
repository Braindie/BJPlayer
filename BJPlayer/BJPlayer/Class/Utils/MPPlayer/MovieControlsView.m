//
//  MovieControlsView.m
//  MobileStudy
//
//  Created by chenxili on 14/12/10.
//
//

#import "MovieControlsView.h"

@interface MovieControlsView ()

@property(nonatomic,strong)UILabel *titileLab;//上部显示视频名称的标签；

@property(nonatomic,strong)UILabel *timeLab;//播放时间段显示

@property(nonatomic,strong)UIButton *screenSwitchBtn;//屏幕大小转换

@property(nonatomic,strong) UIImageView *backProgressBar;
@property(nonatomic,strong) UIImageView *playProgressBar;
@property(nonatomic,strong) UIImageView *playableProgressBar;
@property(nonatomic,strong) UIButton *playerPoint;

@property(nonatomic,assign) float playValueprogress;
@property(nonatomic,assign) float playableValueprogress;
@end

@implementation MovieControlsView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

//初始化播放控件
- (void)initView{
        
    self.backgroundColor=[UIColor clearColor];
    
    //上部浮出框
    self.topViewBar=[[UIView alloc] init];
    self.topViewBar.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:self.topViewBar];
    //当前课程名称
    self.titileLab=[[UILabel alloc] init];
    self.titileLab.textColor=[UIColor whiteColor];
    self.titileLab.text = @"视频";
    self.titileLab.backgroundColor=[UIColor clearColor];
    self.titileLab.font=[UIFont systemFontOfSize:13];
    self.titileLab.textAlignment=NSTextAlignmentCenter;
    [self.topViewBar addSubview:self.titileLab];
    
    
    //底部浮出框
    self.bottomViewBar=[[UIView alloc] init];
    self.bottomViewBar.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:self.bottomViewBar];
    //播放按钮
    self.playBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn setImage:[UIImage imageNamed:@"video_suspended"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"video_suspended0"] forState:UIControlStateNormal];
    self.playBtn.frame=CGRectMake(10, 5, 30, 30);
    [self.playBtn addTarget:self action:@selector(playBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomViewBar addSubview:self.playBtn];
    //进度条
    self.backProgressBar=[[UIImageView alloc] init];
    [self.backProgressBar setImage:[UIImage imageNamed:@"progress_cross.png"]];
    [self.bottomViewBar addSubview:self.backProgressBar];
    self.backProgressBar.userInteractionEnabled = YES;
    //进度条
    self.playableProgressBar=[[UIImageView alloc] init];
    [self.playableProgressBar setImage:[UIImage imageNamed:@"progress_cross_o.png"]];
    [self.bottomViewBar addSubview:self.playableProgressBar];
    //进度条
    self.playProgressBar=[[UIImageView alloc] init];
    [self.playProgressBar setImage:[UIImage imageNamed:@"progress_cross_ok.png"]];
    [self.bottomViewBar addSubview:self.playProgressBar];
    //进度点
    self.playerPoint=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.playerPoint setImage:[UIImage imageNamed:@"progress_point"] forState:UIControlStateNormal];
    [self.bottomViewBar addSubview:self.playerPoint];
    //全屏切换
    self.screenSwitchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.screenSwitchBtn setImage:[UIImage imageNamed:@"video_max"] forState:UIControlStateNormal];
    self.screenSwitchBtn.frame=CGRectMake(self.frame.size.width-40, 5, 30, 30);
    [self.screenSwitchBtn addTarget:self action:@selector(screenSwitchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomViewBar addSubview:self.screenSwitchBtn];
    //播放时间显示
    self.timeLab=[[UILabel alloc] init];
    self.timeLab.text=@"00:00/00:00";
    self.timeLab.textColor=[UIColor whiteColor];
    self.timeLab.font=[UIFont systemFontOfSize:12];
    self.timeLab.backgroundColor=[UIColor clearColor];
    self.timeLab.frame=CGRectMake(50, 15, 120, 25);
    [self.bottomViewBar addSubview:self.timeLab];
    
    [self UpdateFrame];
}

//更新进度条
- (void)drawRect:(CGRect)rect{
    [self UpdateFrame];
}

-(void)UpdateFrame{
    
    float width=self.frame.size.width;
    float height=self.frame.size.height;
    
    self.topViewBar.frame=CGRectMake(0, 0, width, width/8);
    self.bottomViewBar.frame=CGRectMake(0, height-width/8, width, width/8);
    
    
    CGSize timeSize = [self.timeLab.text sizeWithFont:[UIFont systemFontOfSize:12]];
    
    CGFloat progressW = width - timeSize.width;
    self.backProgressBar.frame=CGRectMake(50, 20, progressW-105, 10);
    //orgin.x - 8的原因是因为位置在更新的时候还需要减去自身的宽度的一半，不然进度条上的点会跳动一下，不信你去掉试一试？
    self.playerPoint.frame=CGRectMake(self.playValueprogress*(progressW-105)+50 - 8, 17, 16, 16);
    self.playProgressBar.frame=CGRectMake(50, 20, self.playValueprogress*(progressW-105), 10);
    self.playableProgressBar.frame=CGRectMake(50, 20, self.playableValueprogress*(progressW-105), 10);
    //        self.timeLab.frame=CGRectMake(self.backProgressBar.right + 10, self.backProgressBar.top-8, timeSize.width, 25);
    
    self.screenSwitchBtn.frame=CGRectMake(width-40, 5, 40, 40);
    
    self.playBtn.frame=CGRectMake(10, 10, 30, 30);
    self.backProgressBar.frame=CGRectMake(50, 10, width-105, 10);
    //orgin.x - 8的原因是因为位置在更新的时候还需要减去自身的宽度的一半，不然进度条上的点会跳动一下，不信你去掉试一试？
    self.playerPoint.frame=CGRectMake(self.playValueprogress*(width-105)+50 - 8, 7, 16, 16);
    self.playProgressBar.frame=CGRectMake(50, 10, self.playValueprogress*(width-105), 10);
    self.playableProgressBar.frame=CGRectMake(50, 10, self.playableValueprogress*(width-105), 10);
    self.timeLab.frame=CGRectMake(50, 18, 120, 25);
    
    self.screenSwitchBtn.frame=CGRectMake(width-40, 5, 30, 30);
    [self.screenSwitchBtn setImage:[UIImage imageNamed:@"video_max"] forState:UIControlStateNormal];
    
    
    self.playBtn.frame=CGRectMake(10, 5, 30, 30);
    
    self.titileLab.frame=CGRectMake(10, 0, width-20, width/8);
    self.titileLab.font=[UIFont systemFontOfSize:13];
    
    if ([self.delegate respondsToSelector:@selector(IsPlaying)]) {
        if ([self.delegate IsPlaying]) {
            [self.playBtn setImage:[UIImage imageNamed:@"suspended"] forState:UIControlStateNormal];
        }else{
            [self.playBtn setImage:[UIImage imageNamed:@"video_play_x"] forState:UIControlStateNormal];
        }
    }
}


#pragma mark - 点击事件
//返回
-(void)backBtnClicked:(id)sender{
}
//播放
-(void)playBtnClicked:(id)sender{
    [_delegate playBtnClicked];
}
//屏幕转换
-(void)screenSwitchBtnClicked:(id)sender
{
}
//上一节
-(void)upBtnClicked:(id)sender
{
    [_delegate upBtnClicked];
}
//下一节
-(void)nextBtnClicked:(id)sender
{
    [_delegate nextBtnClicked];
}
//收放课程列表
-(void)courseListBtnClicked:(id)sender
{
    [_delegate courseListBtnClicked];
}
//锁定、解锁屏幕
-(void)lockBtnClicked:(id)sender
{
    [_delegate lockBtnClicked];
}
-(void)ChangedValue:(UISlider *)sender
{
    [_delegate ChangedValue:sender.value];
}
@end

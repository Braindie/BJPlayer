//
//  MovieControlsView.m
//  MobileStudy
//
//  Created by chenxili on 14/12/10.
//
//

#import "MovieControlsView.h"

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
    
    //返回
    self.backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setImage:[UIImage imageNamed:@"video_back"] forState:UIControlStateNormal];
    self.backBtn.frame=CGRectMake(10, 5, 40, 30);
//    [GlobalFunc SetImageButton:self.backBtn Normal:@"video_back.png" Highlight:@"" Clicked:@""];
    [self.backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topViewBar addSubview:self.backBtn];
    
    //当前课程名称
    self.titileLab=[[UILabel alloc] init];
    self.titileLab.frame=CGRectMake(10, 0, 300, 320/8);
    self.titileLab.textColor=[UIColor whiteColor];
    self.titileLab.text = @"野生动物";
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
//    [GlobalFunc SetImageButton:self.playerPoint Normal:@"progress_point.png" Highlight:@"point0.png" Clicked:@""];
    [self.playerPoint setImage:[UIImage imageNamed:@"progress_point"] forState:UIControlStateNormal];
    [self.bottomViewBar addSubview:self.playerPoint];
    
    //全屏切换
    self.screenSwitchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.screenSwitchBtn setImage:[UIImage imageNamed:@"video_max"] forState:UIControlStateNormal];
//    [GlobalFunc SetImageButton:self.screenSwitchBtn Normal:@"video_max.png" Highlight:@"video_max0.png" Clicked:@"video_max0.png"];
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
    
    //上一章节
    self.upBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.upBtn addTarget:self action:@selector(upBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [GlobalFunc SetImageButton:self.upBtn Normal:@"vide_back_on.png" Highlight:@"vide_back.png" Clicked:@"vide_back.png"];
//    [GlobalFunc SetImageButton:self.upBtn Normal:@"video_episode.png" Highlight:@"video_episode0.png" Clicked:@""];
    [self.upBtn setImage:[UIImage imageNamed:@"video_episode"] forState:UIControlStateNormal];
    [self.bottomViewBar addSubview:self.upBtn];
    
    //下一章节
    self.nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextBtn addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [GlobalFunc SetImageButton:self.nextBtn Normal:@"vide_forward_on.png" Highlight:@"vide_forward_on.png" Clicked:@"vide_forward_on.png"];
//    [GlobalFunc SetImageButton:self.nextBtn Normal:@"video_next.png" Highlight:@"video_next0.png" Clicked:@""];
    [self.nextBtn setImage:[UIImage imageNamed:@"video_next"] forState:UIControlStateNormal];
    [self.bottomViewBar addSubview:self.nextBtn];
    
    //课程列表的收放
    self.courseListBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.courseListBtn addTarget:self action:@selector(courseListBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [GlobalFunc SetImageButton:self.courseListBtn Normal:@"video_directory.png" Highlight:@"video_directory0.png" Clicked:@"video_directory0.png"];
    [self.courseListBtn setImage:[UIImage imageNamed:@"video_directory"] forState:UIControlStateNormal];
    [self.bottomViewBar addSubview:self.courseListBtn];
    
    //锁屏、解锁
    self.lockBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.lockBtn.hidden=YES;
    [self.lockBtn addTarget:self action:@selector(lockBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [GlobalFunc SetImageButton:self.lockBtn Normal:@"video_lock.png" Highlight:@"video_lock0.png" Clicked:@"video_lock0.png"];
    [self.bottomViewBar addSubview:self.lockBtn];
}

//更新进度条
- (void)drawRect:(CGRect)rect{
    // Drawing code
    float width=self.frame.size.width;
    float height=self.frame.size.height;
    //顶部浮出框
    self.topViewBar.frame=CGRectMake(0, 0, width, width/8);
    //底部部浮出框
    self.bottomViewBar.frame=CGRectMake(0, height-width/8, width, width/8);
    //返回按钮
    self.backBtn.frame=CGRectMake(10, width/16-20, 40, 40);
    //标题文字
    self.titileLab.frame=CGRectMake(width/8+20, 0, width-width/8-20, width/8);
    self.titileLab.font=[UIFont systemFontOfSize:20];
    //进度条
    self.backProgressBar.frame=CGRectMake(0, 0, width, 10);
    self.playProgressBar.frame=CGRectMake(0, 0, self.playValueprogress*width, 10);
    self.playableProgressBar.frame=CGRectMake(0, 0, self.playableValueprogress*width, 10);
    //进度点
    self.playerPoint.frame=CGRectMake(self.playValueprogress*width, -3, 16, 16);
//    [GlobalFunc SetImageButton:self.playBtn Normal:@"suspended.png" Highlight:@"suspended0.png" Clicked:@""];
    self.playBtn.frame=CGRectMake(width / 2 - 20, width/16-20, 40, 40);
//    self.screenSwitchBtn.frame=CGRectMake(width - 60, self.playBtn.top + 8, 30, 30);
    self.timeLab.frame=CGRectMake(10, 15, 120, 25);
//    self.upBtn.frame=CGRectMake(self.playBtn.left - 50 - 10, self.playBtn.top - 5, 50, 50);
//    self.nextBtn.frame=CGRectMake(self.playBtn.right + 10, self.playBtn.top - 5, 50, 50);
//    self.courseListBtn.frame=CGRectMake(width - 140, self.playBtn.top, 40*4/3, 40);
//    [GlobalFunc SetImageButton:self.screenSwitchBtn Normal:@"video_min.png" Highlight:@"video_min0.png" Clicked:@""];
    
    //锁屏按钮
    self.lockBtn.frame=CGRectMake(width-120, width/16-20, 40, 40);
}


#pragma mark - 全屏切换，改变frame
-(void)UpdateFrame{
    
    float width=self.frame.size.width;
    float height=self.frame.size.height;
    
    self.topViewBar.frame=CGRectMake(0, 0, width, width/8);
    self.bottomViewBar.frame=CGRectMake(0, height-width/8, width, width/8);
    
    
    if (self.isHorizontal){//横屏
        //全屏返回按钮
        self.backBtn.frame=CGRectMake(20, 20, 40, 40);
        
        //标题label
        self.titileLab.frame=CGRectMake(0, 0, 300, width/8);
        self.titileLab.font=[UIFont systemFontOfSize:20];
        
        //进度条
        self.backProgressBar.frame=CGRectMake(0, 5, width, 10);//orgin.x - 8的原因是因为位置在更新的时候还需要减去自身的宽度的一半，不然进度条上的点会跳动一下，不信你去掉试一试？
        self.playProgressBar.frame=CGRectMake(0, 5, self.playValueprogress*width, 10);
        self.playableProgressBar.frame=CGRectMake(0, 5, self.playableValueprogress*width, 10);
        
        //进度点
        self.playerPoint.frame=CGRectMake(self.playValueprogress*width - 8, 2, 16, 16);

        
        if ([self.delegate IsPlaying]) {
            [self.playBtn setImage:[UIImage imageNamed:@"suspended"] forState:UIControlStateNormal];
//            [GlobalFunc SetImageButton:self.playBtn Normal:@"suspended.png" Highlight:@"suspended0.png" Clicked:@""];
        }else{
            [self.playBtn setImage:[UIImage imageNamed:@"video_play_x"] forState:UIControlStateNormal];
//            [GlobalFunc SetImageButton:self.playBtn Normal:@"video_play_x.png" Highlight:@"video_play_x0.png" Clicked:@""];
        }
        
        //播放、暂停按钮
        self.playBtn.frame=CGRectMake(width / 2 - 20, width/16-20, 40, 40);
        
        //全屏按钮
        self.screenSwitchBtn.frame=CGRectMake(width - 60, 15, 30, 30);
        [self.screenSwitchBtn setImage:[UIImage imageNamed:@"video_min"] forState:UIControlStateNormal];

        //时间label
        self.timeLab.frame=CGRectMake(10, 15, 120, 25);
        
        //上一节、下一节
        self.upBtn.frame=CGRectMake(self.frame.size.width/2 - 50 - 15, 15, 50, 50);
        self.nextBtn.frame=CGRectMake(self.frame.size.width/2 + 15, 15, 50, 50);
        
        //目录按钮
        self.courseListBtn.frame=CGRectMake(width - 140, 15, 40*4/3, 40);
        

    }else{//竖屏
        
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
        
        
        if ([self.delegate IsPlaying]) {
            [self.playBtn setImage:[UIImage imageNamed:@"suspended"] forState:UIControlStateNormal];
            //            [GlobalFunc SetImageButton:self.playBtn Normal:@"suspended.png" Highlight:@"suspended0.png" Clicked:@""];
        }else{
            [self.playBtn setImage:[UIImage imageNamed:@"video_play_x"] forState:UIControlStateNormal];
            //            [GlobalFunc SetImageButton:self.playBtn Normal:@"video_play_x.png" Highlight:@"video_play_x0.png" Clicked:@""];
        }
        
    }
    
    self.upBtn.hidden=!self.isHorizontal;
    self.nextBtn.hidden=!self.isHorizontal;
    self.courseListBtn.hidden=!self.isHorizontal;
    self.backBtn.hidden=!self.isHorizontal;
    
    
//    [self.delegate MakeSureIfShowMulu];

    
}


#pragma mark - 点击事件
//返回
-(void)backBtnClicked:(id)sender{
    //    [_delegate backBtnClicked];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"888888" object:nil];
}
//播放
-(void)playBtnClicked:(id)sender{
    [_delegate playBtnClicked];
}
//屏幕转换
-(void)screenSwitchBtnClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"888888" object:nil];
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

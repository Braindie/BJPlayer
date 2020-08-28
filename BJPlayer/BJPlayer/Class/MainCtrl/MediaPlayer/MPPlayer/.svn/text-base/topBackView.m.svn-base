//
//  topBackView.m
//  MobileStudy
//
//  Created by chenxili on 14/12/12.
//
//

#import "topBackView.h"

@implementation topBackView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        int wid=self.bounds.size.width;
        int hei=self.bounds.size.height;
//        self.backgroundColor=RGBACOLOR(142, 195, 030, 0.5);
       
        self.CourseBackView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, wid, hei)];
        [self addSubview:self.CourseBackView];
        
        
        self.backView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, wid, hei)];


#if ISUnicom_Version
	   self.backView.backgroundColor=CreateAlphaColorByRGB(TopBackViewBGColor, 0.9);
        self.backView.alpha = 0.5;
#endif
        [self addSubview:self.backView];
        
        //播放按钮
        self.PlayBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.PlayBtn addTarget:self action:@selector(PlayBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.PlayBtn];
        
        //课程名称
        self.titleLab=[[RCLabel alloc] init];
        self.titleLab.frame=CGRectMake(0, 40, 300, 30);
//        self.titleLab.frame=CGRectMake(0, hei/2+wid/10, wid, 30);

        self.titleLab.font=[UIFont systemFontOfSize:15];
        self.titleLab.backgroundColor=[UIColor redColor];
        self.titleLab.textAlignment=NSTextAlignmentCenter;
        self.titleLab.textColor=[UIColor whiteColor];
        self.titleLab.backgroundColor=[UIColor clearColor];
        [self.backView addSubview:self.titleLab];
        
        
    }
    return self;
}

-(void)PlayBtnClicked
{
     [_delegate topBackPlay];
}

-(void)UPdateFrame
{
    int widd=self.frame.size.width;
    int heii=self.frame.size.height;
    
    self.CourseBackView.frame=CGRectMake(0, 0, widd, heii);
    self.backView.frame=CGRectMake(0, 0, widd, heii);

////    self.PlayBtn.frame=CGRectMake(7*widd/16, heii/2-widd/16, widd/7, widd/7);
//    self.PlayBtn.bounds = CGRectMake(0, 0, widd/5, widd/5);
//    self.PlayBtn.center = CGPointMake(self.backView.center.x, self.backView.center.y -20);//self.backView.center;
//=======
    self.PlayBtn.frame=CGRectMake(widd/2-widd/10, heii/2-widd/10, widd/5, widd/5);

//    self.PlayBtn.bounds = CGRectMake(0, 0, widd/5, widd/5);
//    self.PlayBtn.center = self.backView.center;
//    self.titleLab.frame=CGRectMake(0, heii/2+widd/10, widd, 30);
    
    if (self.isMp4)
    {
        [GlobalFunc SetImageButton:self.PlayBtn Normal:@"play.png" Highlight:@"play.png" Clicked:@"play.png"];
    }
    else
    {
        [GlobalFunc SetImageButton:self.PlayBtn Normal:@"init_html_on" Highlight:@"init_html_off" Clicked:@""];
    }
}
-(void) UpdateRtLabel:(RCLabel *)label
{
    [self.titleLab removeFromSuperview];
    self.titleLab = label;
    self.titleLab.userInteractionEnabled = YES;
    
    [self addSubview:self.titleLab];
}







// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    int widd=self.frame.size.width;
//    int heii=self.frame.size.height;
//
//    NSLog(@"wid==%d,hei==%d",widd,heii);
//
//    self.PlayBtn.frame=CGRectMake(7*widd/16, heii/2-widd/16, widd/8, widd/8);
//    self.titleLab.frame=CGRectMake(0, heii/2+widd/8, widd, 30);
//    self.titleLab.text = self.titleLab.text;
//
//    
//}


@end

//
//  myhintView.m
//  MobileLearningSinopecIpad
//
//  Created by chenxili on 14-9-26.
//  Copyright (c) 2014年 henry. All rights reserved.
//

#import "myhintView.h"

@implementation myhintView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *imagev=[[UIImageView alloc] init];//图片
        imagev.frame=CGRectMake(35, 20, 80, 80);
        self.myImageView=imagev;
        [self addSubview:self.myImageView];
        
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 110, 140, 20)];//说明标签
        lable.font=[UIFont systemFontOfSize:16];
        lable.textColor=[UIColor whiteColor];
        lable.backgroundColor=[UIColor clearColor];
        lable.textAlignment=NSTextAlignmentCenter;
        self.myInformation=lable;
        [self addSubview:self.myInformation];
        
    }
    return self;
}
-(NSString *)transformation:(int)date
{
    NSString *str=nil;
    
    int hour=date/3600;
    int fen=(date-hour*3600)/60;
    int miao=date-hour*3600-fen*60;
    str=[NSString stringWithFormat:@"%02d:%02d:%02d",hour,fen,miao];
    return str;
    
}

-(void)tinkerUp:(float)part With:(float)all
{
    if (self.types==volumType)
    {
        if (part==0.0)
        {
            self.myImageView.image=[UIImage imageNamed:@"voice_no.png"];
        }
        else
        {
            self.myImageView.image=[UIImage imageNamed:@"voice.png"];
        }
        self.myInformation.text=[NSString stringWithFormat:@"%.0f%@",part*100,@"%"];
    }
    else if (self.types==lightType)
    {
        self.myImageView.image=[UIImage imageNamed:@"light.png"];
        self.myInformation.text=[NSString stringWithFormat:@"%.0f%@",part*100,@"%"];
    }
    else if (self.types==progressTypeBackwad || self.types==progressTypeForwad)
    {
        if (self.types==progressTypeForwad)
        {
            self.myImageView.image=[UIImage imageNamed:@"fast.png"];
        }
        else
        {
            self.myImageView.image=[UIImage imageNamed:@"back.png"];
        }
        NSString *partStr=[self transformation:part];
        NSString *allStr=[self transformation:all];
        self.myInformation.text=[NSString stringWithFormat:@"%@/%@",partStr,allStr];

    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

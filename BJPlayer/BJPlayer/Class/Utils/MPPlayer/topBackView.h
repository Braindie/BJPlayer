//
//  topBackView.h
//  MobileStudy
//
//  Created by chenxili on 14/12/12.
//
//

#import <UIKit/UIKit.h>
//#import "RCLabel.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@protocol topBackViewDelegate <NSObject>
-(void)topBackPlay;
@end

@interface topBackView : UIView

//@property(nonatomic,strong)RCLabel *titleLab;//显示课程的名称
@property(nonatomic,strong)UIButton *PlayBtn;//播放按钮
@property(nonatomic,assign)BOOL isMp4;
@property(nonatomic,strong)UIImageView *CourseBackView;
@property(nonatomic,strong)UIView *backView;

@property(nonatomic,assign) id<topBackViewDelegate> delegate;
-(void)UPdateFrame;
//-(void) UpdateRtLabel:(RCLabel *)label;

@end

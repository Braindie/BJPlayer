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
#import <MobileCoreServices/MobileCoreServices.h>
#import "AMProgressView.h"
#import "MovieControlsView.h"


#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface MobilePlayerViewContrl : UIViewController
//是否是本地视频
@property (nonatomic, assign) BOOL isLocalPlay;

//视频播放控制器
@property (nonatomic, strong) MPMoviePlayerViewController *myMoviePlayer;

//视频URL
@property (nonatomic, copy) NSDictionary *myCourseDic;

//外部调用播放事件
- (void) Play;

@end

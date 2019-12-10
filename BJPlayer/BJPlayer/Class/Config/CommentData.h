//
//  CommentData.h
//  BJPlayer
//
//  Created by zhangwenjun on 16/9/20.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

//#ifndef CommentData_h
//#define CommentData_h
//
//
//#endif /* CommentData_h */

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kISPhoneX ([[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0)

#define kStatusBarHeight (kISPhoneX ? 44.f : 20.f) // 加括号啊，不加有坑

#define kNavBarHeight (kStatusBarHeight + 44.f)

#define kTabBarHeight 49.f

typedef enum
{
    Download_Failed,
    Downloading,
    DownloadWaiting,
    DownloadPause,
    DownloadOver,
}Download_State;


//音量，亮度，进度
typedef enum
{
    volumStart,
    lightSrart,
    progressStart,
}PanStartLocation;



typedef enum
{
    Group_Type,
    Plain_Type,
}MyTableViewType;


typedef enum{
    VerticalSupportOnly,
    CrossSupportOnly,
    TreeDirectionSupport,
}ScreenDirectionSupport;

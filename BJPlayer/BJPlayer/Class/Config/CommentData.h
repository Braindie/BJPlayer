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


typedef enum
{
    Download_Failed,
    Downloading,
    DownloadWaiting,
    DownloadPause,
    DownloadOver,
}Download_State;


typedef enum
{
    Group_Type,
    Plain_Type,
}MyTableViewType;


typedef enum
{
    volumStart,
    lightSrart,
    progressStart,
}PanStartLocation;


typedef enum{
    VerticalSupportOnly,
    CrossSupportOnly,
    TreeDirectionSupport,
}ScreenDirectionSupport;

//
//  PlayerViewController.h
//  BJPlayer
//
//  Created by zhangwenjun on 16/11/9.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadModel.h"

@interface PlayerViewController : UIViewController
//播放资源model
@property (nonatomic, strong) DownloadModel *downloadModel;
//是否是本地播放
@property (nonatomic, assign) BOOL isLocalPlayer;

@end

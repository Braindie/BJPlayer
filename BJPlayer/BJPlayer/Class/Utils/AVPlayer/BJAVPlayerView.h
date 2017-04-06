//
//  BJAVPlayerView.h
//  BJPlayer
//
//  Created by zhangwenjun on 17/4/6.
//  Copyright © 2017年 zhangwenjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BJAVPlayerView : UIView

+ (instancetype)initBJAVPlayerView;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;//相当于model层
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

// 播放状态
@property (nonatomic, assign) BOOL isPlaying;
@end

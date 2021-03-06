# BJPlayer

# MPMoviePlayerViewController<MediaPlayer>播放视频

此类是封装了MPMoviePlayerViewController，优化了播放器界面，能够播放在线或本地视频，横竖屏的转换，手势调节进度，改变声音或亮度，自动播放下一节等功能。

#### 说明

- 导入MediaPlayer.framework。
- 导入MPPlayer文件夹。

#### 功能

- 播放或暂停在线或本地视频（本地和网络视频的播放方法不同）
- 支持手势快退/快进改变播放进度
- 支持手势调节亮度/音量
- 支持手动改变上一节/下一节
- 支持自动播放下一节
- 支持保存播放进度
- 支持横屏时显示/隐藏播放列表
- 支持横竖屏切换

#### 类的概述

- MobilePlayerViewContrl是最主要的控制操作类，其中包括控件的代理方法，播放通知方法，定时器，屏幕旋转，离线、断点数据处理方法。
- MovieControlsView是播放器控件的布局，以及播放器状态改变时控件布局的改变。
- CourseTableViewContrl和CourseTableCell是播放目录视图，显示视频播放列表。

#### 使用方法

##### 播放：

点击播放按钮时，隐藏蒙版视图，显示播放视图；
调用播放方法：

```objc
//外部调用播放事件
- (void) Play;
```

#### 其他 ####
- 毛玻璃效果使用了`UIVisualEffectView`>=iOS8
- NSBundle和沙盒的区别
- 沙盒的路径每次重新编译后会改变？（模拟器和真机的区别）？



# AVPlayer<AVFoundation>播放视频
使用AVPlayer播放视频时，提供视频信息的是AVPlayerItem<br>
使用KVO键值观察其属性`status`，当属性为`AVPlayerItemStatusReadyToPlay`时才可播放。

# FFMpeg直播（不支持arm64架构真机没法跑，只能用模拟器了）
使用FFMpeg实现拉流</br>
使用kxmovie进行视频播放</br>


# 其他

## ASI下载
单例模式，断点续传

## FMDB保存数据
保存下载数据


## GIF启动图
使用gif实现启动图的动画效果，用的是xib，没办法用代买控制

## AMProgressView进度条
未使用



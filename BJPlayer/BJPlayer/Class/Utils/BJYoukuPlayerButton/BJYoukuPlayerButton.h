//
//  BJYoukuPlayerButton.h
//  BJPlayer
//
//  Created by zhangwenjun on 2018/6/14.
//  Copyright © 2018年 zhangwenjun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BJYoukuPlayerButtonState) {
    BJYoukuPlayerButtonStatePause,
    BJYoukuPlayerButtonStatePlay
};

@interface BJYoukuPlayerButton : UIButton

@property (nonatomic, assign) BJYoukuPlayerButtonState buttonState;

- (instancetype)initWithFrame:(CGRect)frame withState:(BJYoukuPlayerButtonState)state;

@end

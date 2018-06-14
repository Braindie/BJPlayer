//
//  BJYoukuPlayerButton.m
//  BJPlayer
//
//  Created by zhangwenjun on 2018/6/14.
//  Copyright © 2018年 zhangwenjun. All rights reserved.
//

#import "BJYoukuPlayerButton.h"

//动画时长
static CGFloat animationDuration = 0.35f;
//线条颜色
#define BlueColor [UIColor colorWithRed:62/255.0 green:157/255.0 blue:254/255.0 alpha:1]
#define LightBlueColor [UIColor colorWithRed:87/255.0 green:188/255.0 blue:253/255.0 alpha:1]
#define RedColor [UIColor colorWithRed:228/255.0 green:35/255.0 blue:6/255.0 alpha:0.8]

@interface BJYoukuPlayerButton ()

@property (nonatomic, strong) CAShapeLayer *leftLineLayer;

@property (nonatomic, strong) CAShapeLayer *leftCircleLayer;

@property (nonatomic, strong) CAShapeLayer *rightLineLayer;

@property (nonatomic, strong) CAShapeLayer *rightCircleLayer;

@property (nonatomic, strong) CALayer *triangleCotainerLayer;

@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation BJYoukuPlayerButton

- (instancetype)initWithFrame:(CGRect)frame withState:(BJYoukuPlayerButtonState)state{
    self = [super initWithFrame:frame];
    if (self) {
        if (state == BJYoukuPlayerButtonStatePlay) {
            self.buttonState = state;
        }
        [self bulidUI];
    }
    return self;
}

- (void)bulidUI{
    [self addleftLineLayer];
    [self addRightLineLayer];
    
    [self addLiftCircle];
    [self addRightCircle];
    
    [self addTriangleCotainerLayer];
}


/**
 添加左侧竖线
 */
- (void)addleftLineLayer{
    CGFloat width = self.layer.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.2, width*0.9)];
    [path addLineToPoint:CGPointMake(width*0.2, width*0.1)];
    
    _leftLineLayer = [CAShapeLayer layer];
    _leftLineLayer.path = path.CGPath;
    _leftLineLayer.fillColor = [UIColor clearColor].CGColor;
    _leftLineLayer.strokeColor = BlueColor.CGColor;
    _leftLineLayer.lineWidth = [self lineWidth];
    _leftLineLayer.lineCap = kCALineCapRound;
    _leftLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_leftLineLayer];
}


/**
 添加右侧竖线
 */
- (void)addRightLineLayer{
    CGFloat width = self.layer.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.8, width*0.1)];
    [path addLineToPoint:CGPointMake(width*0.8, width*0.9)];
    
    _rightLineLayer = [CAShapeLayer layer];
    _rightLineLayer.path = path.CGPath;
    _rightLineLayer.fillColor = [UIColor clearColor].CGColor;
    _rightLineLayer.strokeColor = BlueColor.CGColor;
    _rightLineLayer.lineWidth = [self lineWidth];
    _rightLineLayer.lineCap = kCALineCapRound;
    _rightLineLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_rightLineLayer];
}


- (void)addLiftCircle{
    CGFloat width = self.layer.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.2, width*0.9)];
    CGFloat startAngle = acos(4.0/5.0) + M_PI_2;
    CGFloat endAngle = startAngle - M_PI;
    [path addArcWithCenter:CGPointMake(width*0.5, width*0.5) radius:0.5*width startAngle:startAngle endAngle:endAngle clockwise:NO];
    
    _leftCircleLayer = [CAShapeLayer layer];
    _leftCircleLayer.path = path.CGPath;
    _leftCircleLayer.fillColor = [UIColor clearColor].CGColor;
    _leftCircleLayer.strokeColor = LightBlueColor.CGColor;
    _leftCircleLayer.lineWidth = [self lineWidth];
    _leftCircleLayer.lineCap = kCALineCapRound;
    _leftCircleLayer.lineJoin = kCALineJoinRound;

    _leftCircleLayer.strokeEnd = 0;
    [self.layer addSublayer:_leftCircleLayer];
}

- (void)addRightCircle{
    CGFloat width = self.layer.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.8, width*0.1)];
    CGFloat startAngle = -asin(4.0/5.0);
    CGFloat endAngle = startAngle - M_PI;
    [path addArcWithCenter:CGPointMake(width*0.5, width*0.5) radius:width*0.5 startAngle:startAngle endAngle:endAngle clockwise:NO];
    
    _rightCircleLayer = [CAShapeLayer layer];
    _rightCircleLayer.path = path.CGPath;
    _rightCircleLayer.fillColor = [UIColor clearColor].CGColor;
    _rightCircleLayer.strokeColor = LightBlueColor.CGColor;
    _rightCircleLayer.lineWidth = [self lineWidth];
    _rightCircleLayer.lineCap = kCALineCapRound;
    _rightCircleLayer.lineJoin = kCALineJoinRound;
    
    _rightCircleLayer.strokeEnd = 0;
    [self.layer addSublayer:_rightCircleLayer];
}


- (void)addTriangleCotainerLayer{
    CGFloat width = self.layer.bounds.size.width;
    
    _triangleCotainerLayer = [CALayer layer];
    _triangleCotainerLayer.bounds = CGRectMake(0, 0, width*0.4, width*0.35);
    _triangleCotainerLayer.position = CGPointMake(width*0.5, width*0.55);
    _triangleCotainerLayer.opacity = 0;
    [self.layer addSublayer:_triangleCotainerLayer];
    
    
    
    CGFloat b = _triangleCotainerLayer.bounds.size.width;
    CGFloat c = _triangleCotainerLayer.bounds.size.height;
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(0, 0)];
    [path1 addLineToPoint:CGPointMake(b/2, c)];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(b, 0)];
    [path2 addLineToPoint:CGPointMake(b/2, c)];
    
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.path = path1.CGPath;
    layer1.fillColor = [UIColor clearColor].CGColor;
    layer1.strokeColor = RedColor.CGColor;
    layer1.lineWidth = [self lineWidth];
    layer1.lineCap = kCALineCapRound;
    layer1.lineJoin = kCALineJoinRound;
    layer1.strokeEnd = 1;
    [_triangleCotainerLayer addSublayer:layer1];
    
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.path = path2.CGPath;
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.strokeColor = RedColor.CGColor;
    layer2.lineWidth = [self lineWidth];
    layer2.lineCap = kCALineCapRound;
    layer2.lineJoin = kCALineJoinRound;
    layer2.strokeEnd = 1;
    [_triangleCotainerLayer addSublayer:layer2];
    
}


- (CGFloat)lineWidth{
    return self.layer.bounds.size.width * 0.18;
}

- (void)showPlayAnimation{
    
    [self strokeEndAnimationFrom:1 to:0 onLayer:_leftLineLayer name:nil duration:animationDuration/2 delegate:nil];
    [self strokeEndAnimationFrom:1 to:0 onLayer:_rightLineLayer name:nil duration:animationDuration/2 delegate:nil];
    [self strokeEndAnimationFrom:0 to:1 onLayer:_leftCircleLayer name:nil duration:animationDuration delegate:nil];
    [self strokeEndAnimationFrom:0 to:1 onLayer:_rightCircleLayer name:nil duration:animationDuration delegate:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration/4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self actionRotateAnimationClockwise:NO];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self actionTriangleAlphaAnimationFrom:0 to:1 duration:animationDuration/2];
    });
}

- (void)showPauseAnimation {
    [self strokeEndAnimationFrom:1 to:0 onLayer:_leftCircleLayer name:nil duration:animationDuration delegate:nil];
    [self strokeEndAnimationFrom:1 to:0 onLayer:_rightCircleLayer name:nil duration:animationDuration delegate:nil];
    [self actionTriangleAlphaAnimationFrom:1 to:0 duration:animationDuration/2];
    [self actionRotateAnimationClockwise:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self strokeEndAnimationFrom:0 to:1 onLayer:_leftLineLayer name:nil duration:animationDuration/2 delegate:nil];
        [self strokeEndAnimationFrom:0 to:1 onLayer:_rightLineLayer name:nil duration:animationDuration/2 delegate:nil];
    });
}



- (CABasicAnimation *)strokeEndAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue onLayer:(CALayer *)layer name:(NSString *)animationName duration:(CGFloat)duration delegate:(id)delegate{
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = duration;
    strokeEndAnimation.fromValue = @(fromValue);
    strokeEndAnimation.toValue = @(toValue);
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion = NO;
    [strokeEndAnimation setValue:animationName forKey:@"animationName"];
    strokeEndAnimation.delegate = delegate;
    [layer addAnimation:strokeEndAnimation forKey:nil];
    return strokeEndAnimation;
}


- (void)actionRotateAnimationClockwise:(BOOL)clockwise {
    //逆时针旋转
    CGFloat startAngle = 0.0;
    CGFloat endAngle = -M_PI_2;
    CGFloat duration = 0.75 * animationDuration;
    //顺时针旋转
    if (clockwise) {
        startAngle = -M_PI_2;
        endAngle = 0.0;
        duration = animationDuration;
    }
    CABasicAnimation *roateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    roateAnimation.duration = duration; // 持续时间
    roateAnimation.fromValue = [NSNumber numberWithFloat:startAngle];
    roateAnimation.toValue = [NSNumber numberWithFloat:endAngle];
    roateAnimation.fillMode = kCAFillModeForwards;
    roateAnimation.removedOnCompletion = NO;
    [roateAnimation setValue:@"roateAnimation" forKey:@"animationName"];
    [self.layer addAnimation:roateAnimation forKey:nil];
}

- (void)actionTriangleAlphaAnimationFrom:(CGFloat)from to:(CGFloat)to duration:(CGFloat)duration{
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.duration = duration; // 持续时间
    alphaAnimation.fromValue = @(from);
    alphaAnimation.toValue = @(to);
    alphaAnimation.fillMode = kCAFillModeForwards;
    alphaAnimation.removedOnCompletion = NO;
    [alphaAnimation setValue:@"alphaAnimation" forKey:@"animationName"];
    [_triangleCotainerLayer addAnimation:alphaAnimation forKey:nil];
}




- (void)setButtonState:(BJYoukuPlayerButtonState)buttonState{
    if (_isAnimating == YES) {
        return;
    }
    
    _buttonState = buttonState;
    _isAnimating = YES;
    
    if (buttonState == BJYoukuPlayerButtonStatePlay) {
        [self showPlayAnimation];
    }else if (buttonState == BJYoukuPlayerButtonStatePause){
        [self showPauseAnimation];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _isAnimating = NO;
    });
}










@end

//
//  LDJAutoRunLabel.m
//  HorseRaceLamp
//
//  Created by zhangkai on 2017/10/9.
//  Copyright © 2017年 liudejuan. All rights reserved.
//

#import "LDJAutoRunLabel.h"

@interface LDJAutoRunLabel()<CAAnimationDelegate>
{
    CGFloat _width;
    CGFloat _height;
    CGFloat _animationViewWidth;
    CGFloat _animationViewHeight;
    BOOL _stoped;
    UIView *_contentView;//滚动内容视图
}
@property (nonatomic, strong) UIView *animationView;//放置滚动内容视图
@end


@implementation LDJAutoRunLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        _width = frame.size.width;
        _height = frame.size.height;
        
        self.speed = 1.0f;
        self.directionType = LeftType;
        self.layer.masksToBounds = YES;
        self.animationView = [[UIView alloc] initWithFrame:CGRectMake(_width, 0, _width, _height)];
        [self addSubview:self.animationView];
    }
    return self;
}

- (void)addContentView:(UIView *)view {
    
    
    [_contentView removeFromSuperview];
    view.frame = view.bounds;
    _contentView = view;
    self.animationView.frame = view.bounds;
    [self.animationView addSubview:_contentView];
    
    _animationViewWidth = self.animationView.frame.size.width;
    _animationViewHeight = self.animationView.frame.size.height;
}


- (void)startAnimation {
    [self.animationView.layer removeAnimationForKey:@"animationViewPosition"];
    _stoped = NO;
    
    CGPoint pointRightCenter = CGPointMake(_width + _animationViewWidth / 2.f, _animationViewHeight / 2.f);
    CGPoint pointLeftCenter  = CGPointMake(-_animationViewWidth / 2, _animationViewHeight / 2.f);
    CGPoint fromPoint        = self.directionType == LeftType ? pointRightCenter : pointLeftCenter;
    CGPoint toPoint          = self.directionType == LeftType ? pointLeftCenter  : pointRightCenter;
    
    self.animationView.center = fromPoint;
    UIBezierPath *movePath    = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    [movePath addLineToPoint:toPoint];
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path                 = movePath.CGPath;
    moveAnimation.removedOnCompletion  = YES;
    moveAnimation.duration             = _animationViewWidth / 30.f * (1 / self.speed);
    moveAnimation.delegate             = self;
    [self.animationView.layer addAnimation:moveAnimation forKey:@"animationViewPosition"];
}


//停止动画
- (void)stopAnimation {
     _stoped = YES;
      [self.animationView.layer removeAnimationForKey:@"animationViewPosition"];
}

//暂停动画
- (void)pauseAnimation{
    
    if (!_stoped) {
        _stoped = YES;
        [self pauseLayer:self.animationView.layer];
    }
}

//恢复暂停动画
- (void)startPauseAnimation{
    
    if (_stoped) {
        [self resumeLayer:_animationView.layer];
        _stoped = NO;
    }
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.delegate && [self.delegate respondsToSelector:@selector(operateLabel:animationDidStopFinished:)]) {
        [self.delegate operateLabel:self animationDidStopFinished:flag];
    }
    if (flag && !_stoped) {
        [self startAnimation];
    }
}

//暂停动画
- (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    layer.speed = 0;
    
    layer.timeOffset = pausedTime;
}


//恢复动画
- (void)resumeLayer:(CALayer*)layer
{
    //当你是停止状态时，则恢复
    if (_stoped) {
        
        CFTimeInterval pauseTime = [layer timeOffset];
        
        layer.speed = 1.0;
        
        layer.timeOffset = 0.0;
        
        layer.beginTime = 0.0;
        
        CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil]-pauseTime;
        
        layer.beginTime = timeSincePause;
    }
    
}


@end

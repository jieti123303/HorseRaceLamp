//
//  LDJAutoRunLabel.h
//  HorseRaceLamp
//
//  Created by zhangkai on 2017/10/9.
//  Copyright © 2017年 liudejuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDJAutoRunLabel;

typedef NS_ENUM(NSInteger, RunDirectionType) {
    LeftType = 0,
    RightType = 1,
};

@protocol LDJAutoRunLabelDelegate <NSObject>

@optional
- (void)operateLabel: (LDJAutoRunLabel *)autoLabel animationDidStopFinished: (BOOL)finished;

@end

@interface LDJAutoRunLabel : UIView


@property (nonatomic, weak) id <LDJAutoRunLabelDelegate> delegate;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) RunDirectionType directionType;

- (void)addContentView: (UIView *)view;
- (void)startAnimation;
- (void)stopAnimation;
- (void)pauseAnimation;
- (void)startPauseAnimation;

@end

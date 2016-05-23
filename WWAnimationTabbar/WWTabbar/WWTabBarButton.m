//
//  WWTabBarButton.m
//  WWAnimationTabbar
//
//  Created by 天奕 on 16/1/20.
//  Copyright © 2016年 William. All rights reserved.
//

#import "WWTabBarButton.h"

#define circleRadius 10.0

#define Shadow_Color [UIColor colorWithRed:210/255.0 green:130/255.0 blue:60/255.0 alpha:0.6]

@interface WWTabBarButton ()

@property (nonatomic, strong) CAShapeLayer *circlePathLayer;

@property (nonatomic, assign) CGRect circleFrame;

@end

@implementation WWTabBarButton

- (CAShapeLayer *)circlePathLayer {
    if (!_circlePathLayer) {
        _circlePathLayer = [[CAShapeLayer alloc]init];
        _circlePathLayer.frame = self.bounds;
        
        CGRect circleFrame = CGRectMake(0, 0, circleRadius, circleRadius);
        circleFrame.origin.x = CGRectGetMidX(_circlePathLayer.bounds);
        circleFrame.origin.y = CGRectGetMidY(_circlePathLayer.bounds);
        self.circleFrame = circleFrame;
        
        _circlePathLayer.path = [self getSmallCirclePath].CGPath;
        

        self.layer.masksToBounds = YES;
        _circlePathLayer.fillColor = Shadow_Color.CGColor;
        _circlePathLayer.backgroundColor= [UIColor clearColor].CGColor;

        /* 添加到按钮的第一层 这样不会覆盖按钮的Image */
        [self.layer insertSublayer:_circlePathLayer atIndex:0];
    }
    return _circlePathLayer;
}

/* 画小圆 */
- (UIBezierPath *)getSmallCirclePath {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.circleFrame.origin.x, self.circleFrame.origin.y) radius:circleRadius startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    return path;
}
/* 画大圆  */
- (UIBezierPath *)getBigCirclePath {
    /* 求按钮对角线的距离 即为大圆的半径 这样不论点击按钮的任何位置大圆都可完全覆盖 */
    /* 函数功能:已知直角三角形的两个直角边，求斜边*/
    CGFloat bigCircleRadius = hypotf(self.bounds.size.width, self.bounds.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.circleFrame.origin.x, self.circleFrame.origin.y) radius:bigCircleRadius startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    return path;
}

/* 扩张动画 */
- (void)pathExpandAnimate {
    CABasicAnimation *circleAnimtion = [CABasicAnimation animationWithKeyPath:@"path"];
    circleAnimtion.removedOnCompletion = NO;
    circleAnimtion.duration = 0.3;
    circleAnimtion.fromValue = (__bridge id)[self getSmallCirclePath].CGPath;
    circleAnimtion.toValue = (__bridge id)[self getBigCirclePath].CGPath;
    _circlePathLayer.path = [self getBigCirclePath].CGPath;
    [_circlePathLayer addAnimation:circleAnimtion forKey:@"animPath"];
}

- (void)showCircleLayerWithPoint:(CGPoint)position {
    [self circlePathLayer];
    self.circlePathLayer.position = position;/* 传递手指点击的位置 */
    [self pathExpandAnimate];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self sendActionsForControlEvents:UIControlEventTouchDown];/* 执行按钮的事件方法 不写不会执行 */
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self showCircleLayerWithPoint:point];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_circlePathLayer removeFromSuperlayer];
    _circlePathLayer = nil;
}

/* 取消高亮状态 */
-(void)setHighlighted:(BOOL)highlighted {
    //    [super setHighlighted:highlighted];
}

@end

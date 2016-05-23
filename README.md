# WWAnimationTabbar
##谷歌翻译TabBar点击效果动画复刻
#### 效果展示
![image](https://raw.githubusercontent.com/WilliamZhangWH/WWAnimationTabbar/master/screenshot/WWAnimationTabbar.gif)

#### 调用方法
>increasedHeight为0即为系统TabBar高度

```Objective-C
- (instancetype)initWithFrame:(CGRect)frame increasedHeight:(CGFloat)height;
```

####代理方法
>记录从哪里跳转到哪里

```Objective-C
- (void)tabBar:(WWTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to;
```

####按钮点击圆形扩展动画原理
* 原理：创建CAShapeLayer图层，通过UIBezierPath创建两个绘图路径，再通过CABasicAnimation完成两个绘图路径之间动画转变

> 图层创建

```Objective-C
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
```
* 绘图路径创建 （需要创建两个路径，第一个是点击时候出现的一个小圆，第二个是覆盖整个按钮的一个大圆）

> 小圆路径创建

```Objective-C
- (UIBezierPath *)getSmallCirclePath {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.circleFrame.origin.x, self.circleFrame.origin.y) radius:circleRadius startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    return path;
}
```

> 大圆路径创建

```Objective-C
- (UIBezierPath *)getBigCirclePath {
    /* 求按钮对角线的距离 即为大圆的半径 这样不论点击按钮的任何位置大圆都可完全覆盖 */
    /* 函数功能:已知直角三角形的两个直角边，求斜边*/
    CGFloat bigCircleRadius = hypotf(self.bounds.size.width, self.bounds.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.circleFrame.origin.x, self.circleFrame.origin.y) radius:bigCircleRadius startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    return path;
}
```

> 小圆到大圆的扩张动画

```Objective-C
- (void)pathExpandAnimate {
    CABasicAnimation *circleAnimtion = [CABasicAnimation animationWithKeyPath:@"path"];
    circleAnimtion.removedOnCompletion = NO;
    circleAnimtion.duration = 0.3;
    circleAnimtion.fromValue = (__bridge id)[self getSmallCirclePath].CGPath;
    circleAnimtion.toValue = (__bridge id)[self getBigCirclePath].CGPath;
    _circlePathLayer.path = [self getBigCirclePath].CGPath;
    [_circlePathLayer addAnimation:circleAnimtion forKey:@"animPath"];
}
```

> 通过按钮的触摸事件来触发动画的开始和结束

```Objective-C
- (void)showCircleLayerWithPoint:(CGPoint)position {
    [self circlePathLayer];
    self.circlePathLayer.position = position;/* 传递手指点击的位置 */
    [self pathExpandAnimate];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /* 执行按钮的事件方法 不写不会执行 */
    [self sendActionsForControlEvents:UIControlEventTouchDown];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self showCircleLayerWithPoint:point];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_circlePathLayer removeFromSuperlayer];
    _circlePathLayer = nil;
}
```
## Installation

1.手动添加:
- 将WWTabbar文件夹中拖拽到项目中
- 导入头文件：`#import "WWTabbar.h"`

2.pods添加
- pod 'WWAnimationTabbar'

## License

- MIT license.

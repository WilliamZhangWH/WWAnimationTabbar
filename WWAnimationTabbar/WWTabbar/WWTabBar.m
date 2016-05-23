//
//  WWTabBar.m
//  WWAnimationTabbar
//
//  Created by 天奕 on 16/1/20.
//  Copyright © 2016年 William. All rights reserved.
//

#import "WWTabBar.h"
#import "WWTabBarButton.h"

#define Background_Color    [UIColor colorWithRed:227/255.0 green:229/255.0 blue:230/255.0 alpha:1]
#define Slider_Color        [UIColor colorWithRed:214/255.0 green:76/255.0 blue:14/255.0 alpha:1]

#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface WWTabBar ()

@property (nonatomic, weak) UIButton *selectedBtn;

@property (nonatomic, strong) UIView *slidingView;

@end

@implementation WWTabBar

-(UIView *)slidingView {
    if (!_slidingView) {
        _slidingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/3, 4)];
        _slidingView.backgroundColor = Slider_Color;
        [self addSubview:_slidingView];
    }
    return _slidingView;
}

- (instancetype)initWithFrame:(CGRect)frame increasedHeight:(CGFloat)height; {
    CGRect tFrame = frame;
    tFrame.origin.y = frame.origin.y - height;
    tFrame.size.height = frame.size.height + height;
    frame = tFrame;
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView {
    self.backgroundColor = Background_Color;

    [self.layer setShadowOffset:CGSizeMake(-1, -1)];
    [self.layer setShadowColor:[UIColor darkGrayColor].CGColor];
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 2;
    
    [self slidingView];
}

- (void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage index:(NSInteger)index{
    WWTabBarButton *btn = [WWTabBarButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [self addSubview:btn];
    
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
    if (index == 1) {
        btn.selected = YES;
        self.selectedBtn = btn;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = 0;
    NSMutableArray *btnSubviews = [NSMutableArray array];
    for (UIView * subview in self.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [btnSubviews addObject:subview];
            count++;
        }
    }
    for (int i = 0; i < count; i++) {
        UIButton *btn = btnSubviews[i];
        btn.tag = i;
        
        CGFloat x = i * self.bounds.size.width / count;
        CGFloat y = self.slidingView.frame.size.height;
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = self.bounds.size.height - y;
        btn.frame = CGRectMake(x, y, width, height);
    }
}

- (void)clickBtn:(UIButton *)button {
    /* 如果点击不是同一个按钮就切换滑块 */
    if (self.selectedBtn != button) {

        [UIView animateWithDuration:0.2 animations:^{
            CGRect orignFrame = self.slidingView.frame;
            self.slidingView.frame = CGRectMake(WIDTH*button.tag/3, 0, orignFrame.size.width, orignFrame.size.height);
        }];
    }
    
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:button.tag];
    }
}



@end

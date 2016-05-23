//
//  WWTabBar.h
//  WWAnimationTabbar
//
//  Created by 天奕 on 16/1/20.
//  Copyright © 2016年 William. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WWTabBar;

@protocol WWTabBarDelegate <NSObject>
/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里
 */
- (void)tabBar:(WWTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface WWTabBar : UIView

@property (nonatomic, weak) id<WWTabBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame increasedHeight:(CGFloat)height;

/**
 *  使用特定图片来创建按钮
 *
 *  @param image         普通状态下的图片
 *  @param selectedImage 选中状态下的图片
 *  @param index         按钮序号
 */
- (void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *) selectedImage index:(NSInteger)index;

@end

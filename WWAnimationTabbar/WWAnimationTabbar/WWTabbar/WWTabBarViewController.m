//
//  WWTabBarViewController.m
//  WWAnimationTabbar
//
//  Created by 天奕 on 16/1/20.
//  Copyright © 2016年 William. All rights reserved.
//

#import "WWTabBarViewController.h"
#import "WWTabBarButton.h"
#import "WWTabBar.h"

@interface WWTabBarViewController () <WWTabBarDelegate>

@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation WWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect originRect = self.tabBar.frame;
    [self.tabBar removeFromSuperview];
    
    WWTabBar *tabbarView = [[WWTabBar alloc] initWithFrame:originRect increasedHeight:8];
    tabbarView.delegate = self;
    [self.view addSubview:tabbarView];
    
    for (int i = 0; i < self.viewControllers.count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"TabBar%d", i+1];
        NSString *imageNameSel = [NSString stringWithFormat:@"TabBar%dSel", i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        
        [tabbarView addButtonWithImage:image selectedImage:imageSel index:i+1];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WWTabBarDelegate
- (void)tabBar:(WWTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

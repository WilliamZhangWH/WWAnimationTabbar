//
//  WWBaseViewController.m
//  WWAnimationTabbar
//
//  Created by 天奕 on 16/1/21.
//  Copyright © 2016年 William. All rights reserved.
//

#import "WWBaseViewController.h"

@interface WWBaseViewController ()

@end

@implementation WWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:45/255.0 green:48/255.0 blue:51/255.0 alpha:1],NSForegroundColorAttributeName,[UIFont fontWithName:@"HelveticaNeue" size:22.0], NSFontAttributeName,nil]];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  RootNavgationViewController.m
//  DragonupLiCai
//
//  Created by XZB  on 16/1/1.
//  Copyright (c) 2016年 Dragonup. All rights reserved.
//

#import "RootNavgationViewController.h"

@interface RootNavgationViewController ()

@end

@implementation RootNavgationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initNavigation];
}
//-(void)initNavigation
//{
//    //设置导航栏title的颜色
//    NSDictionary *text = @{
//                           NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
//                           NSForegroundColorAttributeName:[UIColor blackColor]};
//    [[UINavigationBar appearance] setTitleTextAttributes:text];
//    //设置导航栏的背景颜色
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
//}

//状态栏的字体
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


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

//
//  AVPlayerViewController.m
//  VR_world
//
//  Created by davysen on 16/3/16.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "AVPlayerViewController.h"
#import "BaiduMobStat.h"

@interface AVPlayerViewController ()

@property (nonatomic, strong) QYAVPlayer *play;

@end

@implementation AVPlayerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString* cName = [NSString stringWithFormat:@"%@",  self.titleName, nil];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSString* cName = [NSString stringWithFormat:@"%@", self.titleName, nil];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"accordBase" object:nil];
    
    [MBProgressHUD showHUDWithMeg:@"正在加载" toView:self.view];
    self.play = [[QYAVPlayer alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) WithUrl:[NSURL URLWithString:_playUrl]];
    [self.play.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.play.title.text = _titleName;
    [self.view addSubview:self.play];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)backBtnAction
{
    [self.play zhuxiao];
    [self.play removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenBase" object:nil];
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

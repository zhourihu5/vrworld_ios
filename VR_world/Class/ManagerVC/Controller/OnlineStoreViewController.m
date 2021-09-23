//
//  OnlineStoreViewController.m
//  VR_world
//
//  Created by davysen on 16/3/29.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "OnlineStoreViewController.h"

@interface OnlineStoreViewController ()

@property (nonatomic, strong) UIImageView *NavBackground;
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UILabel *rightTitle;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation OnlineStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"accordBase" object:nil];
    self.view.backgroundColor = [UIColor blackColor];
    _NavBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 5.9)];
    UIImage *navImg = [UIImage imageNamed:@"bg_titlebar.png"];
    _NavBackground.image = navImg;
    [self.view addSubview:_NavBackground];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 5.9)];
    title.text = @"网上商店";
    title.textColor = [UIColor whiteColor];
    [_NavBackground addSubview:title];
    title.textAlignment = NSTextAlignmentCenter;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, _NavBackground.bottom, SCREEN_WIDTH / 5.242, SCREEN_HEIGHT)];
    leftView.backgroundColor = UICOLOR_RGB(4, 20, 44);
    [self.view addSubview:leftView];
    UILabel *leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH / 5.242, 20)];
    leftTitle.text = @"网上商店";
    leftTitle.textColor = UICOLOR_FROM_HEX(0x01cabe);
    leftTitle.textAlignment = NSTextAlignmentCenter;
    [leftView addSubview:leftTitle];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.backgroundColor = UICOLOR_RGB(44, 122, 135);
    backBtn.frame = CGRectMake((SCREEN_WIDTH / 5.242 - 60) / 2, SCREEN_HEIGHT - 160, 60, 26);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.layer.masksToBounds = YES;
    backBtn.layer.cornerRadius = 6;
    [leftView addSubview:backBtn];
    
    _rightView = [[UIView alloc] initWithFrame:CGRectMake(leftView.right + 5, _NavBackground.bottom + 5, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), SCREEN_HEIGHT - (SCREEN_HEIGHT / 5.9 + 10))];
    _rightView.backgroundColor = UICOLOR_RGB(4, 20, 44);
    _rightView.layer.masksToBounds = YES;
    _rightView.layer.cornerRadius = 5;
    [self.view addSubview:_rightView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), 5)];
    line.backgroundColor = UICOLOR_RGB(44, 122, 135);
    [_rightView addSubview:line];
    
    UIImageView *storeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), SCREEN_HEIGHT - (SCREEN_HEIGHT / 5.9 + 10))];
    UIImage *storeImg = [UIImage imageNamed:@"store"];
    storeImgView.image = storeImg;
    storeImgView.userInteractionEnabled = YES;
    [_rightView addSubview:storeImgView];
                                                                              
    // 微信购买
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxBtn.frame = CGRectMake(SCREEN_HEIGHT / 6.9, SCREEN_HEIGHT - SCREEN_HEIGHT / 2.6, 80, 30);
    [wxBtn setTitle:@"微信购买" forState:UIControlStateNormal];
    wxBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [wxBtn setBackgroundImage:[UIImage imageNamed:@"btnFrame"] forState:UIControlStateNormal];
    [wxBtn addTarget:self action:@selector(wxBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [storeImgView addSubview:wxBtn];

    // 淘宝购买
    UIButton *tbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tbBtn.frame = CGRectMake(SCREEN_WIDTH - (10 + SCREEN_WIDTH / 5.242 + 80 + SCREEN_HEIGHT / 6.9), SCREEN_HEIGHT - SCREEN_HEIGHT / 2.6, 80, 30);
    [tbBtn setTitle:@"淘宝购买" forState:UIControlStateNormal];
    tbBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [tbBtn setBackgroundImage:[UIImage imageNamed:@"btnFrame"] forState:UIControlStateNormal];
    [wxBtn addTarget:self action:@selector(tbBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [storeImgView addSubview:tbBtn];
    
}

// 微信购买
- (void)wxBtnAction
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weidian.com/?userid=161601789"]];
}

// 淘宝购买
- (void)tbBtnAction
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-12814720320.2.ZT7FNT&id=524635369076"]];
}

- (void)backBtnAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenBase" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

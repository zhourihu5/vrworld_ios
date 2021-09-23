//
//  HomePageViewController.m
//  VR_world
//
//  Created by davysen on 16/3/23.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "HomePageViewController.h"
#import "UserInfoViewController.h"
#import "VideoViewController.h"
#import "ManagerViewController.h"

@interface HomePageViewController ()

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIButton *video; // 视频按钮
@property (nonatomic, strong) UIImageView *iconImgView; // 头像
@property (nonatomic, strong) UILabel *name;  // 用户名
@property (nonatomic, strong) UIButton *infoBtn; // 点击头像
@property (nonatomic, strong) UIButton *managerBtn; // 管理

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 5.242, SCREEN_HEIGHT)];
    _baseView.backgroundColor = UICOLOR_RGB(4, 20, 44);
    [[[UIApplication sharedApplication] keyWindow] addSubview:_baseView];
    
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH / 5.242 - 40, SCREEN_WIDTH / 5.242 - 40)];
    circle.backgroundColor = UICOLOR_RGB(44, 122, 135);
    [_baseView addSubview:circle];
    circle.layer.masksToBounds = YES;
    circle.layer.cornerRadius = (SCREEN_WIDTH / 5.242 - 40) / 2;
    UIView *imgBackground = [[UIView alloc] initWithFrame:CGRectMake(3, 3, SCREEN_WIDTH / 5.242 - 40 - 6, SCREEN_WIDTH / 5.242 - 40 - 6)];
    imgBackground.layer.masksToBounds = YES;
    imgBackground.layer.cornerRadius = (SCREEN_WIDTH / 5.242 - 40 - 6) / 2;
    imgBackground.backgroundColor = UICOLOR_RGB(4, 20, 44);
    [circle addSubview:imgBackground];
    
    // 头像
    _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_HEIGHT / 51.75, SCREEN_HEIGHT / 51.75, SCREEN_WIDTH / 5.242 - 40 - 6 - (SCREEN_HEIGHT / 25.875), SCREEN_WIDTH / 5.242 - 40 - 6 - (SCREEN_HEIGHT / 25.875))];
    NSString *faceStr = [NSUSER_DEFAULT objectForKey:@"face"];
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",faceStr]]];
    _iconImgView.layer.masksToBounds = YES;
    _iconImgView.userInteractionEnabled = YES;
    _iconImgView.layer.cornerRadius = (SCREEN_WIDTH / 5.242 - 40 - 6 - (SCREEN_HEIGHT / 25.875)) / 2;
    [imgBackground addSubview:_iconImgView];
    
    // 点击头像加手势
    _infoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _infoBtn.frame = CGRectMake(SCREEN_HEIGHT / 51.75, SCREEN_HEIGHT / 51.75, SCREEN_WIDTH / 5.242 - 40 - 6 - (SCREEN_HEIGHT / 25.875), SCREEN_WIDTH / 5.242 - 40 - 6 - (SCREEN_HEIGHT / 25.875));
    [_iconImgView addSubview:_infoBtn];
    [_infoBtn addTarget:self action:@selector(infoAction) forControlEvents:UIControlEventTouchUpInside];
//    UITapGestureRecognizer *tapIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoAction)];
//    [imgBackground addGestureRecognizer:tapIcon];
    
    // 用户名字
    _name = [[UILabel alloc] initWithFrame:CGRectMake(0, circle.bottom + SCREEN_HEIGHT / 41.4, SCREEN_WIDTH / 5.242, 20)];
    _name.textColor = UICOLOR_RGB(44, 122, 135);
    _name.text = [NSUSER_DEFAULT objectForKey:@"name"];
    _name.textAlignment = NSTextAlignmentCenter;
    _name.font = [UIFont systemFontOfSize:SCREEN_HEIGHT / 27.6];
    [_baseView addSubview:_name];
    
    [self drawBtnView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playAction) name:@"accordBase" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backAction) name:@"hiddenBase" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInfoAction) name:@"changeInfo" object:nil];
}

// 跳到资料
- (void)infoAction
{
    _video.enabled = YES;
    _managerBtn.enabled = YES;
    [_video setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_managerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.navigationController popViewControllerAnimated:NO];
    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
    [self.navigationController pushViewController:userInfoVC animated:NO];
}

- (void)playAction
{
    [_baseView removeFromSuperview];
}

- (void)changeInfoAction
{
    _name.text = [NSUSER_DEFAULT objectForKey:@"name"];
    NSString *faceStr = [NSUSER_DEFAULT objectForKey:@"face"];
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",faceStr]]];
}

- (void)backAction
{
    [[[UIApplication sharedApplication] keyWindow] addSubview:_baseView];
}

- (void)drawBtnView
{
    // 视频
    _video = [UIButton buttonWithType:UIButtonTypeSystem];
    _video.frame = CGRectMake(0, _name.bottom, SCREEN_WIDTH / 5.242, (SCREEN_HEIGHT - (SCREEN_WIDTH / 5.242 + 20)) / 4);
    [_video setTitle:@"视频" forState:UIControlStateNormal];
    [_video setTitleColor:UICOLOR_FROM_HEX(0x01cabe) forState:UIControlStateNormal];
    [_video addTarget:self action:@selector(videoBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_baseView addSubview:_video];
    _video.enabled = NO;
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    [self.navigationController pushViewController:videoVC animated:NO];
    
    // 管理
    _managerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _managerBtn.frame = CGRectMake(0, _video.bottom , SCREEN_WIDTH / 5.242, (SCREEN_HEIGHT - (SCREEN_WIDTH / 5.242 + 20)) / 4);
    [_managerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_managerBtn setTitle:@"管理" forState:UIControlStateNormal];
    [_managerBtn addTarget:self action:@selector(addManagerAction) forControlEvents:UIControlEventTouchUpInside];
    [_baseView addSubview:_managerBtn];
}

// 跳转到视频页面
- (void)videoBtnAction
{
    _video.enabled = NO;
    _managerBtn.enabled = YES;
    [_video setTitleColor:UICOLOR_FROM_HEX(0x01cabe) forState:UIControlStateNormal];
    [_managerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:NO];
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    [self.navigationController pushViewController:videoVC animated:NO];
    
}

// 调到管理页面
- (void)addManagerAction
{
    _video.enabled = YES;
    _managerBtn.enabled = NO;
    [_video setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_managerBtn setTitleColor:UICOLOR_FROM_HEX(0x01cabe) forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:NO];
    ManagerViewController *managerVC = [[ManagerViewController alloc] init];
    [self.navigationController pushViewController:managerVC animated:NO];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight );
    
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate
{
    return YES; 
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

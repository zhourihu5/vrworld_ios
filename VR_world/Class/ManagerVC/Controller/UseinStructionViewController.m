//
//  UseinStructionViewController.m
//  VR_world
//
//  Created by davysen on 16/3/29.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "UseinStructionViewController.h"

@interface UseinStructionViewController ()

@property (nonatomic, strong) UIImageView *NavBackground;
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;

@property (nonatomic, strong) UIScrollView *scrollView1;
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) UIScrollView *scrollView3;

@end

@implementation UseinStructionViewController

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
    title.text = @"使用说明";
    title.textColor = [UIColor whiteColor];
    [_NavBackground addSubview:title];
    title.textAlignment = NSTextAlignmentCenter;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, _NavBackground.bottom, SCREEN_WIDTH / 5.242, SCREEN_HEIGHT)];
    leftView.backgroundColor = UICOLOR_RGB(4, 20, 44);
    [self.view addSubview:leftView];
    
    // 激活指南
    _btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn1.frame = CGRectMake(0, 0, SCREEN_WIDTH / 5.242, (SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9) / 6);
    _btn1.enabled = NO;
    [_btn1 setTitleColor:UICOLOR_FROM_HEX(0x01cabe) forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
    [_btn1 setTitle:@"激活指南" forState:UIControlStateNormal];
    [leftView addSubview:_btn1];
    
    // 手柄连接
    _btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn2.frame = CGRectMake(0, _btn1.bottom, SCREEN_WIDTH / 5.242, (SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9) / 6);
    [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn2 setTitle:@"手柄连接" forState:UIControlStateNormal];
    [_btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
//    [leftView addSubview:_btn2];
    
    // 使用说明
    _btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn3.frame = CGRectMake(0, _btn1.bottom, SCREEN_WIDTH / 5.242, (SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9) / 6);
    [_btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn3 setTitle:@"使用说明" forState:UIControlStateNormal];
    [_btn3 addTarget:self action:@selector(btn3Action) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:_btn3];
    
    // 常见方法
    _btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn4.frame = CGRectMake(0, _btn2.bottom, SCREEN_WIDTH / 5.242, (SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9) / 6);
    [_btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn4 setTitle:@"常见问题" forState:UIControlStateNormal];
    [_btn4 addTarget:self action:@selector(btn4Action) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:_btn4];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.backgroundColor = UICOLOR_RGB(44, 122, 135);
    backBtn.frame = CGRectMake((SCREEN_WIDTH / 5.242 - 60) / 2, _btn4.bottom + 80, 60, 26);
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
    
    [self drawActivateGuide];
    [self drawUseIntroduction];
    [self drawCommonProblems];
}

- (void)btn1Action
{
    [_rightView addSubview:_scrollView1];
    [_scrollView2 removeFromSuperview];
    [_scrollView3 removeFromSuperview];
    _btn1.enabled = NO;
    _btn2.enabled = YES;
    _btn3.enabled = YES;
    _btn4.enabled = YES;
    [_btn1 setTitleColor:UICOLOR_FROM_HEX(0x01cabe) forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)btn2Action
{
    [_scrollView1 removeFromSuperview];
    _btn1.enabled = YES;
    _btn2.enabled = NO;
    _btn3.enabled = YES;
    _btn4.enabled = YES;
    [_btn2 setTitleColor:UICOLOR_FROM_HEX(0x01cabe) forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

- (void)btn3Action
{
    [_rightView addSubview:_scrollView2];
    [_scrollView1 removeFromSuperview];
    [_scrollView3 removeFromSuperview];
    _btn3.enabled = NO;
    _btn2.enabled = YES;
    _btn1.enabled = YES;
    _btn4.enabled = YES;
    [_btn3 setTitleColor:UICOLOR_FROM_HEX(0x01cabe) forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

- (void)btn4Action
{
    [_scrollView1 removeFromSuperview];
    [_scrollView2 removeFromSuperview];
    [_rightView addSubview:_scrollView3];
    _btn4.enabled = NO;
    _btn2.enabled = YES;
    _btn3.enabled = YES;
    _btn1.enabled = YES;
    [_btn4 setTitleColor:UICOLOR_FROM_HEX(0x01cabe) forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

// 激活指南
- (void)drawActivateGuide
{
    _scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 50), SCREEN_HEIGHT - (SCREEN_HEIGHT / 5.9 + 10 + 40))];
    [_rightView addSubview:_scrollView1];
    _scrollView1.pagingEnabled = YES;
    _scrollView1.contentSize = CGSizeMake((SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 50)) * 3, 0);
    _scrollView1.showsHorizontalScrollIndicator = NO;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, _scrollView1.bottom, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 50), 19)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
//    [_rightView addSubview:label];
   
    for (int i = 0; i < 3; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * (SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 50)), 0, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 50), SCREEN_HEIGHT - (SCREEN_HEIGHT / 5.9 + 10 + 40))];
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"sta_0%d",i]];
        imgView.image = img;
        [_scrollView1 addSubview:imgView];
    }
}

// 使用说明
- (void)drawUseIntroduction
{
    _scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 50), SCREEN_HEIGHT - (SCREEN_HEIGHT / 5.9 + 10 + 40))];
    _scrollView2.pagingEnabled = YES;
    _scrollView2.contentSize = CGSizeMake((SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 50)) * 3, 0);
    _scrollView2.showsHorizontalScrollIndicator = NO;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, _scrollView2.bottom, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 50), 19)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    //    [_rightView addSubview:label];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * (SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 50)), 0, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 50), SCREEN_HEIGHT - (SCREEN_HEIGHT / 5.9 + 10 + 40))];
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"sta_0%d",i]];
        imgView.image = img;
        [_scrollView2 addSubview:imgView];
    }
}

// 常见问题
- (void)drawCommonProblems
{
    _scrollView3 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), SCREEN_HEIGHT - (SCREEN_HEIGHT / 5.9 + 10))];
    _scrollView3.pagingEnabled = YES;
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), 13)];
    title1.text = @"①经常提示手机未激活是怎么回事？";
    title1.textColor = UICOLOR_FROM_HEX(0x01cabe);
    title1.font = [UIFont systemFontOfSize:13];
    [_scrollView3 addSubview:title1];
    CGFloat height1 = [self textHeight:@"答：VR世界定制游戏，需激活手机VR功能配合Gevek Touch手柄使用，您不玩大型定制VR游戏，无需激活。"];
    UILabel *answer1 = [[UILabel alloc] initWithFrame:CGRectMake(0, title1.bottom, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), height1)];
    answer1.text = @"答：VR世界定制游戏，需激活手机VR功能配合Gevek Touch手柄使用，您不玩大型定制VR游戏，无需激活。";
    answer1.numberOfLines = 0;
    answer1.font = [UIFont systemFontOfSize:13];
    answer1.textColor = [UIColor whiteColor];
    [_scrollView3 addSubview:answer1];
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(0, answer1.bottom + 5, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), 13)];
    title2.text = @"②为什么定制游戏下载后打开是单屏模式？";
    title2.font = [UIFont systemFontOfSize:13];
    title2.textColor = UICOLOR_FROM_HEX(0x01cabe);
    [_scrollView3 addSubview:title2];
    CGFloat height2 = [self textHeight:@"答：您需要在VR世界打开游戏，流程：打开VR世界，在VR舱页面进入添加游戏，点击自动添加。返回VR舱连接手柄，打开游戏，即可。"];
    UILabel *answer2 = [[UILabel alloc] initWithFrame:CGRectMake(0, title2.bottom, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), height2)];
    answer2.text = @"答：您需要在VR世界打开游戏，流程：打开VR世界，在VR舱页面进入添加游戏，点击自动添加。返回VR舱连接手柄，打开游戏，即可。";
    answer2.numberOfLines = 0;
    answer2.font = [UIFont systemFontOfSize:13];
    answer2.textColor = [UIColor whiteColor];
    [_scrollView3 addSubview:answer2];
    
    UILabel *title3 = [[UILabel alloc] initWithFrame:CGRectMake(0, answer2.bottom + 5, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), 13)];
    title3.text = @"③去哪里购买VR设备，体验身临其境的感觉。";
    title3.font = [UIFont systemFontOfSize:13];
    title3.textColor = UICOLOR_FROM_HEX(0x01cabe);
    [_scrollView3 addSubview:title3];
    CGFloat height3 = [self textHeight:@"答：管理版块-网上商店内有VR头盔和游戏手柄供您选择。"];
    UILabel *answer3 = [[UILabel alloc] initWithFrame:CGRectMake(0, title3.bottom, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), height3)];
    answer3.text = @"答：管理版块-网上商店内有VR头盔和游戏手柄供您选择。";
    answer3.numberOfLines = 0;
    answer3.font = [UIFont systemFontOfSize:13];
    answer3.textColor = [UIColor whiteColor];
    [_scrollView3 addSubview:answer3];
    
    UILabel *title4 = [[UILabel alloc] initWithFrame:CGRectMake(0, answer3.bottom + 5, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), 13)];
    title4.text = @"④我的手机可以激活VR功能吗？";
    title4.font = [UIFont systemFontOfSize:13];
    title4.textColor = UICOLOR_FROM_HEX(0x01cabe);
    [_scrollView3 addSubview:title4];
    CGFloat height4 = [self textHeight:@"答：这是已开通VR功能，手机机型表，其中有您的机型则可以激活；没有您的机型，欢迎反馈给小喵喵！"];
    UILabel *answer4 = [[UILabel alloc] initWithFrame:CGRectMake(0, title4.bottom, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), height4)];
    answer4.text = @"答：这是已开通VR功能，手机机型表，其中有您的机型则可以激活；没有您的机型，欢迎反馈给小喵喵！";
    answer4.numberOfLines = 0;
    answer4.font = [UIFont systemFontOfSize:13];
    answer4.textColor = [UIColor whiteColor];
    [_scrollView3 addSubview:answer4];
    
    UILabel *title5 = [[UILabel alloc] initWithFrame:CGRectMake(0, answer4.bottom + 5, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), 13)];
    title5.text = @"⑤没我爱看的视频怎么办？";
    title5.font = [UIFont systemFontOfSize:13];
    title5.textColor = UICOLOR_FROM_HEX(0x01cabe);
    [_scrollView3 addSubview:title5];
    CGFloat height5 = [self textHeight:@"答：您可以将您爱看的视频，名称，类型反馈给小喵喵！小喵喵会及时回复您。"];
    UILabel *answer5 = [[UILabel alloc] initWithFrame:CGRectMake(0, title5.bottom, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), height5)];
    answer5.text = @"答：您可以将您爱看的视频，名称，类型反馈给小喵喵！小喵喵会及时回复您。";
    answer5.numberOfLines = 0;
    answer5.font = [UIFont systemFontOfSize:13];
    answer5.textColor = [UIColor whiteColor];
    [_scrollView3 addSubview:answer5];
    
    UILabel *title6 = [[UILabel alloc] initWithFrame:CGRectMake(0, answer5.bottom + 5, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), 13)];
    title6.text = @"⑥我用《VR世界》观看普通视频有什么效果？";
    title6.font = [UIFont systemFontOfSize:13];
    title6.textColor = UICOLOR_FROM_HEX(0x01cabe);
    [_scrollView3 addSubview:title6];
    CGFloat height6 = [self textHeight:@"答：您用《VR世界》观看本地视频会有身临其境大屏IMAX效果。"];
    UILabel *answer6 = [[UILabel alloc] initWithFrame:CGRectMake(0, title6.bottom, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), height6)];
    answer6.text = @"答：您用《VR世界》观看本地视频会有身临其境大屏IMAX效果。";
    answer6.numberOfLines = 0;
    answer6.font = [UIFont systemFontOfSize:13];
    answer6.textColor = [UIColor whiteColor];
    [_scrollView3 addSubview:answer6];
    
    UILabel *title7 = [[UILabel alloc] initWithFrame:CGRectMake(0, answer6.bottom + 5, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), 13)];
    title7.text = @"⑦怎么激活手机VR功能？";
    title7.font = [UIFont systemFontOfSize:13];
    title7.textColor = UICOLOR_FROM_HEX(0x01cabe);
    [_scrollView3 addSubview:title7];
    CGFloat height7 = [self textHeight:@"答：您好，这是教程链接  http://bbs.gevek.com  如还有疑惑请致电010-56197811"];
    UILabel *answer7 = [[UILabel alloc] initWithFrame:CGRectMake(0, title7.bottom, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), height7)];
    answer7.text = @"答：您好，这是教程链接  http://bbs.gevek.com  如还有疑惑请致电010-56197811";
    answer7.numberOfLines = 0;
    answer7.font = [UIFont systemFontOfSize:13];
    answer7.textColor = [UIColor whiteColor];
    [_scrollView3 addSubview:answer7];
    
    UILabel *title8 = [[UILabel alloc] initWithFrame:CGRectMake(0, answer7.bottom + 5, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), 13)];
    title8.text = @"⑧VR头盔使用问题：";
    title8.font = [UIFont systemFontOfSize:13];
    title8.textColor = UICOLOR_FROM_HEX(0x01cabe);
    [_scrollView3 addSubview:title8];
    CGFloat height8 = [self textHeight:@"①打开头盔前盖，②打开《VR世界》游戏/视频，③头盔前方中线对准游戏/视频中线，④戴上头盔找个舒服的位置独享盛筵。"];
    UILabel *answer8 = [[UILabel alloc] initWithFrame:CGRectMake(0, title8.bottom, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), height8)];
    answer8.text = @"①打开头盔前盖，②打开《VR世界》游戏/视频，③头盔前方中线对准游戏/视频中线，④戴上头盔找个舒服的位置独享盛筵。";
    answer8.numberOfLines = 0;
    answer8.font = [UIFont systemFontOfSize:13];
    answer8.textColor = [UIColor whiteColor];
    [_scrollView3 addSubview:answer8];
    
    _scrollView3.contentSize = CGSizeMake(SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10), 8 * 13 + (height1 + height2 + height3 + height4 + height5 + height6 + height7 + height8 + 100 + 5 * 8));
}

- (CGFloat)textHeight:(NSString *)str{
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 10) - 200, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    return rect.size.height;
    
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

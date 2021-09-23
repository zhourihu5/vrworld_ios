//
//  LoginViewController.m
//  VR_world
//
//  Created by davysen on 16/3/21.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisViewController.h"
#import "HomePageViewController.h"
#import "FindPassWordViewController.h"
#import "BaiduMobStat.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *background; // 背景图
@property (nonatomic, strong) UITextField *accountText; // 账号
@property (nonatomic, strong) UITextField *pwdText; // 密码
@property (nonatomic, strong) UIButton *findPwd; // 忘记密码
@property (nonatomic, strong) UIButton *loginBtn; // 登录按钮
@property (nonatomic, strong) UIButton *regisBtn; // 注册
@property (nonatomic, strong) UIActivityIndicatorView *activity; // 菊花

@end

@implementation LoginViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString* cName = [NSString stringWithFormat:@"登录页面:%@",  self.view, nil];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawLoginView];

}

// 绘制登录页面
- (void)drawLoginView
{
    _background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImage *backgroundImg = [UIImage imageNamed:@"loginBack"];
    _background.image = backgroundImg;
    _background.userInteractionEnabled = YES;
    [self.view addSubview:_background];
    
    // 账号
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300) / 2, 0, 340, 100)];
    textView.center = self.view.center;
    [_background addSubview:textView];
    
    // logo
    UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 45, textView.top - SCREEN_HEIGHT / 4.3, SCREEN_WIDTH / 6, SCREEN_WIDTH / 8)];
    UIImage *logoImg = [UIImage imageNamed:@"logo"];
    logoImgView.image = logoImg;
    [_background addSubview:logoImgView];
    
    // 账号
    UIImageView *accountIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 22, 25)];
    UIImage *imgIcon = [UIImage imageNamed:@"iconfont-wode"];
    accountIcon.image = imgIcon;
    [textView addSubview:accountIcon];
    _accountText = [[UITextField alloc] initWithFrame:CGRectMake(accountIcon.right + 20, 0, 280, 48)];
    
    // 修改占位符字体
    UIColor *color = [UIColor lightGrayColor];
    _accountText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"accountPl", nil) attributes:@{NSForegroundColorAttributeName:color}];
    _accountText.font = [UIFont systemFontOfSize:23];
    _accountText.textColor = UICOLOR_FROM_HEX(0xa5a5a5);
    [textView addSubview:_accountText];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, accountIcon.bottom + 4, 340, 1)];
    line1.backgroundColor = UICOLOR_FROM_HEX(0xa5a5a5);
    [textView addSubview:line1];
    
    // 密码
    UIImageView *pwdIconView = [[UIImageView alloc] initWithFrame:CGRectMake(20, line1.bottom + 20, 22, 25)];
    UIImage *pwdIcon = [UIImage imageNamed:@"iconfont-mima"];
    pwdIconView.image = pwdIcon;
    [textView addSubview:pwdIconView];
    _pwdText = [[UITextField alloc] initWithFrame:CGRectMake(pwdIconView.right + 20, line1.bottom + 10, 280, 48)];
    _pwdText.font = [UIFont systemFontOfSize:23];
    _pwdText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"pwdPl", nil) attributes:@{NSForegroundColorAttributeName:color}];
    _pwdText.secureTextEntry = YES;
    _pwdText.textColor = UICOLOR_FROM_HEX(0xa5a5a5);
    [textView addSubview:_pwdText];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, pwdIconView.bottom + 4, 340, 1)];
    line2.backgroundColor = UICOLOR_FROM_HEX(0xa5a5a5);
    [textView addSubview:line2];
    
    // 忘记密码
    _findPwd = [UIButton buttonWithType:UIButtonTypeSystem];
    _findPwd.frame = CGRectMake((SCREEN_WIDTH - 340) / 2 + 4, textView.bottom, 130, 15);
    
    // 文字居左对齐
    _findPwd.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_findPwd setTitle:NSLocalizedString(@"ForgotPassword", nil) forState:UIControlStateNormal];
    [_findPwd setTitleColor:UICOLOR_FROM_HEX(0xa5a5a5) forState:UIControlStateNormal];
    [_findPwd addTarget:self action:@selector(findBtnActyion) forControlEvents:UIControlEventTouchUpInside];
    [_background addSubview:_findPwd];
    
    // 立即注册
    _regisBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _regisBtn.frame = CGRectMake(textView.right - 95, textView.bottom, 90, 15);
    [_regisBtn setTitleColor:UICOLOR_FROM_HEX(0xa5a5a5) forState:UIControlStateNormal];
    _regisBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    NSString *str2 = NSLocalizedString(@"RegisterNow", nil);
    [_regisBtn setTitle:str2 forState:UIControlStateNormal];
    [_regisBtn addTarget:self action:@selector(regisBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_background addSubview:_regisBtn];
    
    // 登录按钮
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.frame = CGRectMake((SCREEN_WIDTH - 340) / 2, _findPwd.bottom + 30, 340, SCREEN_HEIGHT / 9);
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = SCREEN_HEIGHT / 9 / 2;
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:SCREEN_HEIGHT / 14.42];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.backgroundColor = UICOLOR_FROM_HEX(0x01cabe);
    [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:NSLocalizedString(@"login", nil) forState:UIControlStateNormal];
    [_background addSubview:_loginBtn];
    
    _accountText.delegate = self;
    _pwdText.delegate = self;
}

// 忘记密码
- (void)findBtnActyion
{
    FindPassWordViewController *findVC = [[FindPassWordViewController alloc] init];
    [self.navigationController pushViewController:findVC animated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height + 216 + SCREEN_HEIGHT / 2);
    if (offset <= 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// 登录
- (void)loginBtnAction
{
    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activity.center = self.view.center;
    [_background addSubview:_activity];
    [_activity startAnimating];
    [self getLoginUrlAccount:_accountText.text pwd:_pwdText.text type:@"2"];
}

// 登录接口
- (void)getLoginUrlAccount:(NSString *)account pwd:(NSString *)pwd type:(NSString *)type
{
    [HttpNetworkingTool post:[NSString stringWithFormat:@"%@api/GameApi/login",DEFAULT_SERVER_IP] params:@{@"account":account,@"password":pwd,@"type":type} success:^(id responseObj) {
        NSDictionary *dic = responseObj;
        [_activity stopAnimating];
        NSString *errnoStr = [NSString stringWithFormat:@"%@",dic[@"errno"]];
        [MBProgressHUD showError:dic[@"errmsg"] toView:_background];
        NSString *errmsgStr = dic[@"errmsg"];
        if ([errnoStr isEqualToString:@"0"]) {
            HomePageViewController *homeVC = [[HomePageViewController alloc] init];
            [self.navigationController pushViewController:homeVC animated:NO];
            
            [NSUSER_DEFAULT setBool:YES forKey:@"LoginStatus"];
            [NSUSER_DEFAULT setObject:self.accountText.text forKey:@"userTel"];
            [NSUSER_DEFAULT setObject:self.pwdText.text forKey:@"passWord"];
            // id
            [NSUSER_DEFAULT setObject:dic[@"data"][@"id"] forKey:@"id"];
            [NSUSER_DEFAULT setObject:dic[@"data"][@"nickname"] forKey:@"name"];
            // 初始头像
            [NSUSER_DEFAULT setObject:dic[@"data"][@"face"] forKey:@"face"];
            [NSUSER_DEFAULT setObject:dic[@"data"][@"signature"] forKey:@"signature"];
            // 等级
            [NSUSER_DEFAULT setObject:dic[@"data"][@"grade"] forKey:@"grade"];
            [NSUSER_DEFAULT synchronize];
            
        } else {
            [MBProgressHUD showError:errmsgStr toView:self.view];
        }
    } failure:^(NSError *error) {
        
    }];
}

// 到注册界面
- (void)regisBtnAction
{
    RegisViewController *regisVC = [[RegisViewController alloc] init];
    [self.navigationController pushViewController:regisVC animated:YES];
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

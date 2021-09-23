//
//  RegisViewController.m
//  VR_world
//
//  Created by davysen on 16/3/21.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "RegisViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "LoginViewController.h"

@interface RegisViewController ()<UITextFieldDelegate>
{
    NSInteger secondsCountDown; // 60秒计时
    NSTimer *countDownTimer; // 计时器
}
@property (nonatomic, strong) UIImageView *bankground; // 背景图
@property (nonatomic, strong) UITextField *accoundText; // 账号
@property (nonatomic, strong) UITextField *codeText; // 验证码
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UITextField *pwdText; // 密码
@property (nonatomic, strong) UITextField *confirmPwd;
@property (nonatomic, strong) UIButton *regisBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *backBtn; // 返回按钮
@property (nonatomic, strong) UIActivityIndicatorView *activity; // 菊花

@end

@implementation RegisViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawRegisView];
    _accoundText.delegate = self;
    _codeText.delegate = self;
    _pwdText.delegate = self;
    _confirmPwd.delegate = self;
}

// 绘制注册页面
- (void)drawRegisView
{
    _bankground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bankground.userInteractionEnabled = YES;
    UIImage *backgroundImg = [UIImage imageNamed:@"loginBack"];
    _bankground.image = backgroundImg;
    [self.view addSubview:_bankground];
    
    // 返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _backBtn.frame = CGRectMake(20, 30, 25, 25);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_bankground addSubview:_backBtn];
    
    // view
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 320) / 2, 120, 360, 175)];
    bigView.center = self.view.center;
    [self.view addSubview:bigView];
    
    UIImageView *accountImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 22, 25)];
    UIImage *accountImg = [UIImage imageNamed:@"iconfont-wode"];
    accountImgView.image = accountImg;
    [bigView addSubview:accountImgView];
    _accoundText = [[UITextField alloc] initWithFrame:CGRectMake(accountImgView.right + 20, 10, 305, 35)];
    // 修改占位符字体
    UIColor *color = [UIColor lightGrayColor];
    _accoundText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"accountPl", nil) attributes:@{NSForegroundColorAttributeName:color}];
    _accoundText.textColor = UICOLOR_FROM_HEX(0xa5a5a5);
    _accoundText.font = [UIFont systemFontOfSize:23];
    [bigView addSubview:_accoundText];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, accountImgView.bottom + 6, 360, 1)];
    line1.backgroundColor = UICOLOR_FROM_HEX(0xa5a5a5);
    [bigView addSubview:line1];
    
    // 验证码
    UIImageView *codeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, line1.bottom + 17, 22, 18)];
    UIImage *codeImg = [UIImage imageNamed:@"iconfont-yanzhengma"];
    codeImgView.image = codeImg;
    [bigView addSubview:codeImgView];
    _codeText = [[UITextField alloc] initWithFrame:CGRectMake(codeImgView.right + 20, line1.bottom + 10, 360 - 90 - 62, 35)];
    _codeText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"code", nil) attributes:@{NSForegroundColorAttributeName:color}];
    _codeText.font = [UIFont systemFontOfSize:23];
    _codeText.textColor = UICOLOR_FROM_HEX(0xa5a5a5);
    [bigView addSubview:_codeText];
    _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _codeBtn.backgroundColor = UICOLOR_FROM_HEX(0x333c45);
    _codeBtn.titleLabel.alpha = 2;
    [_codeBtn setTitle:NSLocalizedString(@"code", nil) forState:UIControlStateNormal];
    [_codeBtn addTarget:self action:@selector(codeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_codeBtn setTitleColor:UICOLOR_FROM_HEX(0xa5a5a5) forState:UIControlStateNormal];
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    _codeBtn.layer.masksToBounds = YES;
    _codeBtn.layer.cornerRadius = 12.5;
    _codeBtn.frame = CGRectMake(360 - 90, line1.bottom + 14, 80, 25);
    [bigView addSubview:_codeBtn];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, codeImgView.bottom + 6, 360, 1)];
    line2.backgroundColor = UICOLOR_FROM_HEX(0xa5a5a5);
    [bigView addSubview:line2];
    
    // 密码
    UIImageView *pwdImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, line2.bottom + 12, 22, 25)];
    UIImage *pwdImg = [UIImage imageNamed:@"iconfont-mima"];
    pwdImgView.image = pwdImg;
    [bigView addSubview:pwdImgView];
    _pwdText = [[UITextField alloc] initWithFrame:CGRectMake(pwdImgView.right + 20, line2.bottom + 10, 360 - 62, 35)];
    _pwdText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"pwdPl", nil) attributes:@{NSForegroundColorAttributeName:color}];
    _pwdText.font = [UIFont systemFontOfSize:23];
    _pwdText.textColor =  UICOLOR_FROM_HEX(0xa5a5a5);
    [bigView addSubview:_pwdText];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, pwdImgView.bottom + 6, 360, 1)];
    line3.backgroundColor =  UICOLOR_FROM_HEX(0xa5a5a5);
    [bigView addSubview:line3];
    
    // 确认密码
    UIImageView *configImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, line3.bottom + 12, 22, 25)];
    UIImage *configImg = [UIImage imageNamed:@"iconfont-mima"];
    configImgView.image = configImg;
    [bigView addSubview:configImgView];
    _confirmPwd = [[UITextField alloc] initWithFrame:CGRectMake(configImgView.right + 20, line3.bottom + 10, 360 - 62, 35)];
    _confirmPwd.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"confirmPwdPl", nil) attributes:@{NSForegroundColorAttributeName:color}];
    _confirmPwd.textColor = UICOLOR_FROM_HEX(0xa5a5a5);
    _confirmPwd.font = [UIFont systemFontOfSize:23];
    [bigView addSubview:_confirmPwd];
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, configImgView.bottom + 6, 360, 1)];
    line4.backgroundColor = UICOLOR_FROM_HEX(0xa5a5a5);
    [bigView addSubview:line4];
    
    // 注册按钮
    _regisBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _regisBtn.frame = CGRectMake(bigView.left + 15, bigView.bottom + SCREEN_HEIGHT / 12.5, 140, SCREEN_HEIGHT / 9);
    _regisBtn.layer.masksToBounds = YES;
    _regisBtn.layer.cornerRadius = SCREEN_HEIGHT / 9 / 2;
    _regisBtn.titleLabel.font = [UIFont systemFontOfSize:SCREEN_HEIGHT / 14.42];
    [_regisBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_regisBtn addTarget:self action:@selector(registBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _regisBtn.backgroundColor = UICOLOR_FROM_HEX(0x01cabe);
    [_regisBtn setTitle:NSLocalizedString(@"register", nil) forState:UIControlStateNormal];
    [_bankground addSubview:_regisBtn];
    
    // 取消
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelBtn.frame = CGRectMake(bigView.right - 140 - 15, bigView.bottom + SCREEN_HEIGHT / 12.5, 140, SCREEN_HEIGHT / 9);
    _cancelBtn.layer.masksToBounds = YES;
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelBtn.layer.cornerRadius = SCREEN_HEIGHT / 9 / 2;
    _cancelBtn.backgroundColor = UICOLOR_FROM_HEX(0x333c45);
    [_cancelBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:SCREEN_HEIGHT / 14.42];
    [_cancelBtn setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
    [_bankground addSubview:_cancelBtn];
    
}

// 获取验证码按钮
- (void)codeBtnAction
{
    [self getCodeAccound:self.accoundText.text];
}

// 获取验证码方法
- (void)getCodeAccound:(NSString *)accound
{
    NSString *regexPhoneNum = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *predPhoneNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPhoneNum];
    BOOL isMatchPhoneNum = [predPhoneNum evaluateWithObject:accound];
    if (!isMatchPhoneNum){
        //手机号码不匹配
        UIAlertView *alertPhoneNum=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您输入的号码有误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        
        [alertPhoneNum show];
        
    }else {
        //发送验证码
        //请求验证码
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:accound
         
                                       zone:@"86"
         
                           customIdentifier:nil
         
                                     result:^(NSError *error)
         {
             if (!error) {
                 
                 secondsCountDown = 60;
                 countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                 _codeBtn.enabled = NO;
                 _codeBtn.backgroundColor = UICOLOR_FROM_HEX(0xe5e5e5);
                 [MBProgressHUD showSuccess:@"验证码已发送，请注意查收" toView:self.view];
             } else {
                 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                       
                                                                 message:[NSString stringWithFormat:@"错误描述：%@",[error.userInfo objectForKey:@"getVerificationCode"]]
                                       
                                                                delegate:self
                                       
                                                       cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                       
                                                       otherButtonTitles:nil, nil];
                 [alert show];
             }
         }];
    }
}

// 注册按钮
- (void)registBtnAction
{
//    判断手机号的正则表达式
    NSString *regexPhoneNum = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *predPhoneNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPhoneNum];
    BOOL isMatchPhoneNum = [predPhoneNum evaluateWithObject:self.accoundText.text];
    
    if ([_accoundText.text isEqualToString:@""] || [_codeText.text isEqualToString:@""] || [_pwdText.text isEqualToString:@""] || [_confirmPwd.text isEqualToString:@""]) {
        [MBProgressHUD showSuccess:@"请输入完整信息" toView:self.view];
    } else if (!isMatchPhoneNum){
            //手机号码不匹配
            [MBProgressHUD showSuccess:@"您输入的号码有误" toView:self.view];
    } else {
        if (![_pwdText.text isEqualToString:_confirmPwd.text]) {
            [MBProgressHUD showSuccess:@"两次输入的密码不一致" toView:self.view];
        } else if ((_pwdText.text.length < 6) || (_confirmPwd.text.length < 6)) {
            [MBProgressHUD showError:@"密码至少为6位数" toView:self.view];
        } else {
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activity.center = self.view.center;
        [_bankground addSubview:_activity];
        [_activity startAnimating];
        [self getRegisterUrlTel:_accoundText.text pwd:_pwdText.text code:_codeText.text zone:@"86" mold:@"1"];
    }
    }
    //判断密码规则的正则表达式（8-20位字母和数字的组合）
//    NSString *regexPassword = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
//    NSPredicate *predPassword = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPassword];
//    BOOL isMatchPassword = [predPassword evaluateWithObject:self.pwdText.text];
  
}

// 注册接口
- (void)getRegisterUrlTel:(NSString *)tel pwd:(NSString *)pwd code:(NSString *)code zone:(NSString *)zone mold:(NSString *)mold
{
    [HttpNetworkingTool post:[NSString stringWithFormat:@"%@api/GameApi/regist",DEFAULT_SERVER_IP] params:@{@"tel":tel,@"password":pwd,@"code":code,@"zone":zone,@"mold":mold} success:^(id responseObj) {
        
        NSDictionary *dic = responseObj;
        NSString *errnoStr = [NSString stringWithFormat:@"%@",dic[@"errno"]];
        if ([errnoStr isEqualToString:@"0"]) {
            [_activity stopAnimating];
            LoginViewController *videoVC = [[LoginViewController alloc] init];
            [MBProgressHUD showSuccess:dic[@"errmsg"] toView:videoVC.view];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } else {
            [_activity stopAnimating];
            [MBProgressHUD showSuccess:dic[@"errmsg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)timeFireMethod {
    secondsCountDown--;
    if (secondsCountDown == 0) {
        [countDownTimer invalidate];
        _codeBtn.enabled = YES;
        _codeBtn.backgroundColor = UICOLOR_FROM_HEX(0x333c45);
        [_codeBtn setTitle:@"验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:UICOLOR_FROM_HEX(0xa5a5a5) forState:UIControlStateNormal];
    } else {
        [_codeBtn setTitle:[NSString stringWithFormat:@"%lds",(long)secondsCountDown] forState:UIControlStateNormal];
        _codeBtn.backgroundColor = UICOLOR_FROM_HEX(0xe5e5e5);
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height + 216 + SCREEN_HEIGHT / 2.76);
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


- (void)backBtnAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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

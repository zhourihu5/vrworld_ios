//
//  FindPassWordViewController.m
//  VR_world
//
//  Created by davysen on 16/3/23.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "RegisViewController.h"
#import "LoginViewController.h"
#import <SMS_SDK/SMSSDK.h>

@interface FindPassWordViewController ()<UITextFieldDelegate>
{
    NSInteger secondsCountDown; // 60秒计时
    NSTimer *countDownTimer; // 计时器
}
@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIView *textView; // 文本框
@property (nonatomic, strong) UITextField *accoundText;
@property (nonatomic, strong) UITextField *codeText;
@property (nonatomic, strong) UITextField *pwdText;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UIButton *confirm; // 确认
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation FindPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _accoundText.delegate = self;
    _codeText.delegate = self;
    _pwdText.delegate = self;
    [self drawView];
    
}

- (void)drawView
{
    _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImage *backImg = [UIImage imageNamed:@"loginBack"];
    _backgroundView.image = backImg;
    _backgroundView.userInteractionEnabled = YES;
    [self.view addSubview:_backgroundView];
    
    // 返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _backBtn.frame = CGRectMake(20, 30, 25, 25);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_backBtn];
    
    // view
    _textView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 320) / 2, 120, 360, 160)];
    _textView.center = self.view.center;
    [self.view addSubview:_textView];
    
    UIImageView *accountImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 22, 25)];
    UIImage *accountImg = [UIImage imageNamed:@"iconfont-wode"];
    accountImgView.image = accountImg;
    [_textView addSubview:accountImgView];
    _accoundText = [[UITextField alloc] initWithFrame:CGRectMake(accountImgView.right + 20, 10, 305, 35)];
    // 修改占位符字体
    UIColor *color = [UIColor lightGrayColor];
    _accoundText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"accountPl", nil) attributes:@{NSForegroundColorAttributeName:color}];
    _accoundText.textColor = UICOLOR_FROM_HEX(0xa5a5a5);
    _accoundText.font = [UIFont systemFontOfSize:23];
    [_textView addSubview:_accoundText];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, accountImgView.bottom + 6, 360, 1)];
    line1.backgroundColor = UICOLOR_FROM_HEX(0xa5a5a5);
    [_textView addSubview:line1];
    
    // 验证码
    UIImageView *codeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, line1.bottom + 17, 22, 18)];
    UIImage *codeImg = [UIImage imageNamed:@"iconfont-yanzhengma"];
    codeImgView.image = codeImg;
    [_textView addSubview:codeImgView];
    _codeText = [[UITextField alloc] initWithFrame:CGRectMake(codeImgView.right + 20, line1.bottom + 10, 360 - 90 - 62, 35)];
    _codeText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"code", nil) attributes:@{NSForegroundColorAttributeName:color}];
    _codeText.font = [UIFont systemFontOfSize:23];
    _codeText.textColor = UICOLOR_FROM_HEX(0xa5a5a5);
    [_textView addSubview:_codeText];
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
    [_textView addSubview:_codeBtn];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, codeImgView.bottom + 6, 360, 1)];
    line2.backgroundColor = UICOLOR_FROM_HEX(0xa5a5a5);
    [_textView addSubview:line2];
    
    // 密码
    UIImageView *pwdImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, line2.bottom + 12, 22, 25)];
    UIImage *pwdImg = [UIImage imageNamed:@"iconfont-mima"];
    pwdImgView.image = pwdImg;
    [_textView addSubview:pwdImgView];
    _pwdText = [[UITextField alloc] initWithFrame:CGRectMake(pwdImgView.right + 20, line2.bottom + 10, 360 - 62, 35)];
    _pwdText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"pwdPl", nil) attributes:@{NSForegroundColorAttributeName:color}];
    _pwdText.font = [UIFont systemFontOfSize:23];
    _pwdText.textColor =  UICOLOR_FROM_HEX(0xa5a5a5);
    [_textView addSubview:_pwdText];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, pwdImgView.bottom + 6, 360, 1)];
    line3.backgroundColor =  UICOLOR_FROM_HEX(0xa5a5a5);
    [_textView addSubview:line3];
    
    _confirm = [UIButton buttonWithType:UIButtonTypeSystem];
    _confirm.frame = CGRectMake(_textView.left, _textView.bottom + SCREEN_HEIGHT / 15, 360, SCREEN_HEIGHT / 9);
    _confirm.backgroundColor = UICOLOR_FROM_HEX(0x01cabe);
    _confirm.layer.masksToBounds = YES;
    _confirm.layer.cornerRadius = SCREEN_HEIGHT / 9 / 2;
    [_confirm setTitle:NSLocalizedString(@"confirm", nil) forState:UIControlStateNormal];
    [_confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirm addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _confirm.titleLabel.font = [UIFont systemFontOfSize:SCREEN_HEIGHT / 14.42];
    [_backgroundView addSubview:_confirm];
}

// 确认按钮
- (void)confirmBtnAction
{
    //    判断手机号的正则表达式
    NSString *regexPhoneNum = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *predPhoneNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPhoneNum];
    BOOL isMatchPhoneNum = [predPhoneNum evaluateWithObject:self.accoundText.text];
    
    if ([_accoundText.text isEqualToString:@""] || [_codeText.text isEqualToString:@""] || [_pwdText.text isEqualToString:@""]) {
        [MBProgressHUD showSuccess:@"请输入完整信息" toView:self.view];
    } else if (!isMatchPhoneNum){
        //手机号码不匹配
        [MBProgressHUD showSuccess:@"您输入的号码有误" toView:self.view];
    } else if (_pwdText.text.length < 6) {
        [MBProgressHUD showError:@"密码至少为6位数" toView:self.view];
    } else {
        [MBProgressHUD showHUDWithMeg:@"正在修改" toView:self.view];
        [self getFindPwdTel:_accoundText.text password:_pwdText.text code:_codeText.text mold:@"1"];
    }
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


- (void)getFindPwdTel:(NSString *)tel password:(NSString *)password code:(NSString *)code mold:(NSString *)mold
{
    [HttpNetworkingTool post:[NSString stringWithFormat:@"%@api/GameApi/retrievepwd",DEFAULT_SERVER_IP] params:@{@"tel":tel,@"password":password,@"code":code,@"zone":@"86",@"mold":mold} success:^(id responseObj) {
        
        NSDictionary *dic = responseObj;
        if ([dic[@"errno"] isEqualToString:@"0"]) {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [MBProgressHUD showHUDWithMeg:dic[@"errmsg"] toView:loginVC.view];
        } else {
            [MBProgressHUD showHUDWithMeg:dic[@"errmsg"] toView:self.view];
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

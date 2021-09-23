//
//  UserFeedbackViewController.m
//  VR_world
//
//  Created by davysen on 16/3/28.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "UserFeedbackViewController.h"

@interface UserFeedbackViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) UIImageView *NavBackground;
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UILabel *rightTitle;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UITextField *accound;
@property (nonatomic, strong) UITextView *connect;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation UserFeedbackViewController

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
    title.text = @"用户反馈";
    title.textColor = [UIColor whiteColor];
    [_NavBackground addSubview:title];
    title.textAlignment = NSTextAlignmentCenter;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, _NavBackground.bottom, SCREEN_WIDTH / 5.242, SCREEN_HEIGHT)];
    leftView.backgroundColor = UICOLOR_RGB(4, 20, 44);
    [self.view addSubview:leftView];
    UILabel *leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH / 5.242, 20)];
    leftTitle.text = @"用户反馈";
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
    
    _rightTitle = [[UILabel alloc] initWithFrame:CGRectMake(-12, 10, 120, 30)];
    _rightTitle.backgroundColor = UICOLOR_RGB(44, 122, 135);
    _rightTitle.text = @"用户反馈\t";
    _rightTitle.textAlignment = NSTextAlignmentRight;
    _rightTitle.layer.cornerRadius = 13;
    _rightTitle.layer.masksToBounds = YES;
    _rightTitle.textColor = [UIColor whiteColor];
    [_rightView addSubview:_rightTitle];
    
    // 提交按钮
    _submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _submitBtn.frame = CGRectMake(SCREEN_WIDTH - 240, 10, 60, 30);
    _submitBtn.backgroundColor = UICOLOR_RGB(44, 122, 135);
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 5;
    [_submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_rightView addSubview:_submitBtn];
    
    
    // 联系方式
    UIColor *color = UICOLOR_FROM_HEX(0x01cabe);
    UILabel *accoundLabel = [[UILabel alloc] initWithFrame:CGRectMake(_rightTitle.bottom + 5, _rightTitle.bottom + 3, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 50), 15)];
    accoundLabel.font = [UIFont systemFontOfSize:11];
    accoundLabel.text = @"联系方式";
    accoundLabel.textColor = [UIColor whiteColor];
    accoundLabel.textAlignment = NSTextAlignmentCenter;
    [_rightView addSubview:accoundLabel];
    _accound = [[UITextField alloc] initWithFrame:CGRectMake(20, accoundLabel.bottom, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 40), 25)];
    _accound.textColor = UICOLOR_FROM_HEX(0x01cabe);
    _accound.layer.borderColor=[UICOLOR_FROM_HEX(0x01cabe)CGColor];
    _accound.layer.borderWidth= 1.0f;
    [_rightView addSubview:_accound];
    _accound.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"\t手机号/微信号/QQ号" attributes:@{NSForegroundColorAttributeName:color}];
    
    // 内容
    UILabel *connectLabel = [[UILabel alloc] initWithFrame:CGRectMake(_rightTitle.bottom + 5, _accound.bottom + 3, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 50), 15)];
    connectLabel.font = [UIFont systemFontOfSize:11];
    connectLabel.text = @"反馈内容";
    connectLabel.textColor = [UIColor whiteColor];
    connectLabel.textAlignment = NSTextAlignmentCenter;
    [_rightView addSubview:connectLabel];
    _connect = [[UITextView alloc] initWithFrame:CGRectMake(20, connectLabel.bottom, SCREEN_WIDTH - (SCREEN_WIDTH / 5.242 + 40), SCREEN_HEIGHT / 2.5)];
    _connect.backgroundColor = UICOLOR_RGB(4, 20, 44);
    _connect.textColor = UICOLOR_FROM_HEX(0x01cabe);
    _connect.layer.borderColor=[UICOLOR_FROM_HEX(0x01cabe)CGColor];
    _connect.layer.borderWidth= 1.0f;
    [_rightView addSubview:_connect];
    _connect.text = @"\t不可以超过200字";
    
    _accound.delegate = self;
    _connect.delegate = self;
}

// 提交
- (void)submitBtnAction
{
    [self getFeedbackUrlTel:_accound.text cont:[_connect.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

// 意见反馈接口
- (void)getFeedbackUrlTel:(NSString *)tel cont:(NSString *)cont
{
    [HttpNetworkingTool post:[NSString stringWithFormat:@"%@api/GameApi/feedback",DEFAULT_SERVER_IP] params:@{@"tel":tel,@"cont":cont} success:^(id responseObj) {
        
        NSDictionary *dic = responseObj;
        if ([[NSString stringWithFormat:@"%@",dic[@"errno"]]  isEqualToString:@"0"]) {
            [MBProgressHUD showHUDWithMeg:dic[@"errmsg"] toView:self.view];
        } else {
            [MBProgressHUD showHUDWithMeg:dic[@"errmsg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        
    }];
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    CGFloat offset = self.view.frame.size.height - (textView.frame.origin.y + textView.frame.size.height + 216 + SCREEN_HEIGHT / 6);
    if (offset <= 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
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

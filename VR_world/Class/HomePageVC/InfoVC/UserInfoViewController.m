//
//  UserInfoViewController.m
//  VR_world
//
//  Created by davysen on 16/3/24.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "UserInfoViewController.h"
#import "BaiduMobStat.h"
//（1）引入框架
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@interface UserInfoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL isEdit;
    int num;
    NSMutableArray* _dataList;//数据数组
}
@property (nonatomic, strong) UIImageView *navImgView;
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIImageView *userIcon;
@property (nonatomic, strong) UIButton *userInfoBtn; // 用户信息
@property (nonatomic, strong) UIButton *changePwd; // 改密码
@property (nonatomic, strong) UIButton *setBtn;
@property (nonatomic, strong) UIButton *backBtn; // 返回按钮
@property (nonatomic, strong) UIImageView *leftView;
@property (nonatomic, strong) UIImageView *infoView;
@property (nonatomic, strong) UIImageView *pwdView;
@property (nonatomic, strong) UIImageView *setView;

@property (nonatomic, strong) UILabel *idText;
@property (nonatomic, strong) UILabel *gradeText;
@property (nonatomic, strong) UITextField *nickText;
@property (nonatomic, strong) UITextField *telText;
@property (nonatomic, strong) UITextField *signatureText;
@property (nonatomic, strong) UIButton *infoBtn; // 更改信息
@property (nonatomic, strong) UITextField *account; // 修改密码需要
@property (nonatomic, strong) UITextField *newsPwd;
@property (nonatomic, strong) UIButton *changePwdBtn;
@property(strong,nonatomic)NSData *imageData;
@property(nonatomic,strong)UIImage *pickImage;//获取相册返回的图片赋值给上传头像
@property(copy,nonatomic)NSString *base64Str;//获取图片的64编码

@end

//（2）宏定义
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
@implementation UserInfoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //让屏幕bu可以旋转
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeRotate" object:@"1"];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (num == 1) {
        NSString* cName = [NSString stringWithFormat:@"退出登录:%@", self.view, nil];
        [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    num = 0;
    
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"accordBase" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backAction) name:@"userInfoVCBack" object:nil];
    [self drawUserInfoView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInfoAction) name:@"changeInfo" object:nil];
}

- (void)drawUserInfoView
{
    // 创建导航栏view
    _navImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 5.9)];
    UIImage *img = [UIImage imageNamed:@"bg_titlebar.png"];
    _navImgView.image = img;
    [self.view addSubview:_navImgView];
    _navImgView.userInteractionEnabled = YES;
    _background = [[UIImageView alloc] initWithFrame:CGRectMake(0, _navImgView.bottom, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242), SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9)];
    UIImage *backImg = [UIImage imageNamed:@"bg_2.jpg"];
    _background.image = backImg;
    _background.userInteractionEnabled = YES;
    [self.view addSubview:_background];
    
    _leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 4.6, SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9)];
    _leftView.userInteractionEnabled = YES;
    UIImage *leftImg = [UIImage imageNamed:@"矩形"];
    _leftView.image = leftImg;
    [_background addSubview:_leftView];
    
    _userInfoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _userInfoBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 4.6, 40);
    [_userInfoBtn setTitle:@"个人资料" forState:UIControlStateNormal];
    [_userInfoBtn setTitleColor:UICOLOR_RGB(44, 122, 135) forState:UIControlStateNormal];
    [_userInfoBtn addTarget:self action:@selector(infoAction) forControlEvents:UIControlEventTouchUpInside];
    [_leftView addSubview:_userInfoBtn];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, _userInfoBtn.bottom, SCREEN_WIDTH / 4.6, 2)];
    line1.backgroundColor = [UIColor blackColor];
    [_leftView addSubview:line1];
    
    _changePwd = [UIButton buttonWithType:UIButtonTypeSystem];
    _changePwd.frame = CGRectMake(0, line1.bottom, SCREEN_WIDTH / 4.6, 40);
    [_changePwd addTarget:self action:@selector(changePwdAction) forControlEvents:UIControlEventTouchUpInside];
    [_changePwd setTitle:@"修改密码" forState:UIControlStateNormal];
    [_changePwd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leftView addSubview:_changePwd];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _changePwd.bottom, SCREEN_WIDTH / 4.6, 2)];
    line2.backgroundColor = [UIColor blackColor];
    [_leftView addSubview:line2];
    
    _setBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _setBtn.frame = CGRectMake(0, line2.bottom, SCREEN_WIDTH / 4.6, 40);
    [_setBtn addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    [_setBtn setTitle:@"设置" forState:UIControlStateNormal];
    [_setBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leftView addSubview:_setBtn];
    
    // 返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _backBtn.frame = CGRectMake(0, _setBtn.bottom + 50, 50, 30);
    _backBtn.backgroundColor = UICOLOR_RGB(44, 122, 135);
    _backBtn.frame = CGRectMake((SCREEN_WIDTH / 5.242 - 60) / 2, SCREEN_HEIGHT - 160, 60, 26);
    [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    _backBtn.layer.masksToBounds = YES;
    _backBtn.layer.cornerRadius = 6;
    [_leftView addSubview:_backBtn];
    
    //**********************************************
    // 个人资料
    _infoView = [[UIImageView alloc] initWithFrame:CGRectMake(_leftView.right + 8, 0, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) - 11 - SCREEN_WIDTH / 4.6, SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9)];
    _infoView.userInteractionEnabled = YES;
    _infoView.image = leftImg;
    [_background addSubview:_infoView];
    // 头像
    _userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10,(SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9) / 5 , 80, 80)];
    NSString *faceStr = [NSUSER_DEFAULT objectForKey:@"face"];
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",faceStr]]];
    _userIcon.layer.masksToBounds = YES;
    _userIcon.layer.cornerRadius = 40;
    [_infoView addSubview:_userIcon];
    _userIcon.userInteractionEnabled = YES;
    // 修改头像
    UITapGestureRecognizer *tapIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIconAction)];
    [_userIcon addGestureRecognizer:tapIcon];
    
    // 资料
    _idText = [[UILabel alloc] initWithFrame:CGRectMake(_userIcon.right + 30, 30, 100, 20)];
    _idText.textColor = [UIColor whiteColor];
    _idText.text = [NSUSER_DEFAULT objectForKey:@"id"];
    [_infoView addSubview:_idText];
    _gradeText = [[UILabel alloc] initWithFrame:CGRectMake(_userIcon.right + 30, _idText.bottom + 10, 100, 20)];
    _gradeText.text = [NSUSER_DEFAULT objectForKey:@"grade"];
    _gradeText.textColor = [UIColor whiteColor];
    [_infoView addSubview:_gradeText];
    _nickText = [[UITextField alloc] initWithFrame:CGRectMake(_userIcon.right + 30, _gradeText.bottom + 10, 100, 20)];
    _nickText.text = [NSUSER_DEFAULT objectForKey:@"name"];
    _nickText.textColor = [UIColor whiteColor];
    _nickText.enabled = NO;
    _nickText.borderStyle = UITextBorderStyleLine;
    [_infoView addSubview:_nickText];
    _telText = [[UITextField alloc] initWithFrame:CGRectMake(_userIcon.right + 30, _nickText.bottom + 10, 150, 20)];
    _telText.text = [NSUSER_DEFAULT objectForKey:@"userTel"];
    _telText.textColor = [UIColor whiteColor];
    [_infoView addSubview:_telText];
    _telText.enabled = NO;
    _signatureText = [[UITextField alloc] initWithFrame:CGRectMake(_userIcon.right + 30, _telText.bottom + 10, 150, 20)];
    _signatureText.text = [NSUSER_DEFAULT objectForKey:@"signature"];
    _signatureText.textColor = [UIColor whiteColor];
    _signatureText.enabled = NO;
    _signatureText.borderStyle = UITextBorderStyleLine;
    [_infoView addSubview:_signatureText];
    _infoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _infoBtn.frame = CGRectMake(_userIcon.right + 30, _signatureText.bottom + 30, 60, 30);
    _infoBtn.backgroundColor = UICOLOR_RGB(44, 122, 135);
    _infoBtn.layer.masksToBounds = YES;
    _infoBtn.layer.cornerRadius = 4;
    [_infoBtn setTitle:@"修改" forState:UIControlStateNormal];
    [_infoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_infoBtn addTarget:self action:@selector(infoChangeAction) forControlEvents:UIControlEventTouchUpInside];
    [_infoView addSubview:_infoBtn];
    
    // 修改密码
    _pwdView = [[UIImageView alloc] initWithFrame:CGRectMake(_leftView.right + 8, 0, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) - 11 - SCREEN_WIDTH / 4.6, SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9)];
    _pwdView.userInteractionEnabled = YES;
    _pwdView.image = leftImg;
    _account = [[UITextField alloc] initWithFrame:CGRectMake(50, SCREEN_HEIGHT / 8.28, 100, 30)];
    _account.text = [NSUSER_DEFAULT objectForKey:@"id"];
    _account.enabled = NO;
    _account.textColor = [UIColor whiteColor];
//    _account.borderStyle = UITextBorderStyleLine;
    [_pwdView addSubview:_account];
    _newsPwd = [[UITextField alloc] initWithFrame:CGRectMake(50, _account.bottom + SCREEN_HEIGHT / 8.28, 100, 30)];
    _newsPwd.enabled = NO;
    _newsPwd.placeholder = @"请输入密码";
    _newsPwd.textColor = [UIColor whiteColor];
    _newsPwd.borderStyle = UITextBorderStyleLine;
    [_pwdView addSubview:_newsPwd];
    _changePwdBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _changePwdBtn.frame = CGRectMake(50, SCREEN_HEIGHT - 160, 90, 30);
    [_changePwdBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [_changePwdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_changePwdBtn addTarget:self action:@selector(changePwdBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _changePwdBtn.backgroundColor = UICOLOR_RGB(44, 122, 135);
    _changePwdBtn.layer.masksToBounds = YES;
    _changePwdBtn.layer.cornerRadius = 4;
    [_pwdView addSubview:_changePwdBtn];
    
    // 设置
    _setView = [[UIImageView alloc] initWithFrame:CGRectMake(_leftView.right + 8, 0, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) - 11 - SCREEN_WIDTH / 4.6, SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9)];
    _setView.userInteractionEnabled = YES;
    _setView.image = leftImg;
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exitBtn.frame = CGRectMake(50, SCREEN_HEIGHT - 160, 160, 30);
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitBtnActin) forControlEvents:UIControlEventTouchUpInside];
    exitBtn.backgroundColor = UICOLOR_RGB(44, 122, 135);
    exitBtn.layer.masksToBounds = YES;
    exitBtn.layer.cornerRadius = 4;
    [_setView addSubview:exitBtn];

}

// 修改资料
- (void)infoChangeAction
{
    isEdit = !isEdit;
    if (isEdit) {
        [_infoBtn setTitle:@"保存" forState:UIControlStateNormal];
        _signatureText.enabled = YES;
        _nickText.enabled = YES;
    } else {
        [_infoBtn setTitle:@"修改" forState:UIControlStateNormal];
        _signatureText.enabled = NO;
        _nickText.enabled = NO;
        [self changePwdGetUrlId:[NSUSER_DEFAULT objectForKey:@"id"] nickName:[_nickText.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] signature:[_signatureText.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
}

// 改密码
- (void)changePwdBtnAction
{
    isEdit = !isEdit;
    if (isEdit) {
        _newsPwd.enabled = YES;
        [_changePwdBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        } else {
        [_changePwdBtn setTitle:@"修改密码" forState:UIControlStateNormal];
        _newsPwd.enabled = NO;
        if (_newsPwd.text.length < 6) {
            [MBProgressHUD showError:@"密码至少为6位数" toView:self.view];
        } else {
            [self getChangePwdId:[NSUSER_DEFAULT objectForKey:@"id"] password:_newsPwd.text];
        }
    }
}

// 退出登录
- (void)exitBtnActin
{
    num++;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"accordBase" object:nil];
    [NSUSER_DEFAULT setBool:NO forKey:@"LoginStatus"];
    [NSUSER_DEFAULT setObject:@"" forKey:@"passWord"];
    [NSUSER_DEFAULT synchronize];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)infoAction
{
    [_userInfoBtn setTitleColor:UICOLOR_RGB(44, 122, 135) forState:UIControlStateNormal];
    [_changePwd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_setBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_background addSubview:_infoView];
    [_pwdView removeFromSuperview];
    [_setView removeFromSuperview];
}

- (void)changePwdAction
{
    [_userInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_changePwd setTitleColor:UICOLOR_RGB(44, 122, 135) forState:UIControlStateNormal];
    [_setBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_background addSubview:_pwdView];
    [_infoView removeFromSuperview];
    [_setView removeFromSuperview];
}

- (void)setAction
{
    [_userInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_changePwd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_setBtn setTitleColor:UICOLOR_RGB(44, 122, 135) forState:UIControlStateNormal];
    [_background addSubview:_setView];
    [_infoView removeFromSuperview];
    [_pwdView removeFromSuperview];
}

// 修改用户信息
- (void)changePwdGetUrlId:(NSString *)Id nickName:(NSString *)nickName signature:(NSString *)signature
{
    [HttpNetworkingTool post:[NSString stringWithFormat:@"%@api/GameApi/editmyself",DEFAULT_SERVER_IP] params:@{@"id":Id,@"nickname":nickName,@"signature":signature} success:^(id responseObj) {
        
        NSDictionary *dic = responseObj;
        if ([[NSString stringWithFormat:@"%@",dic[@"errno"]] isEqualToString:@"0"]) {
            [self getLoginUrlAccount:[NSUSER_DEFAULT objectForKey:@"userTel"] pwd:[NSUSER_DEFAULT objectForKey:@"passWord"] type:@"2"];
            [MBProgressHUD showHUDWithMeg:dic[@"errmsg"] toView:_background];
        } else {
            [MBProgressHUD showHUDWithMeg:dic[@"errmsg"] toView:_background];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

// 登录接口
- (void)getLoginUrlAccount:(NSString *)account pwd:(NSString *)pwd type:(NSString *)type
{
    [HttpNetworkingTool post:[NSString stringWithFormat:@"%@api/GameApi/login",DEFAULT_SERVER_IP] params:@{@"account":account,@"password":pwd,@"type":type} success:^(id responseObj) {
        NSDictionary *dic = responseObj;
        NSString *errnoStr = [NSString stringWithFormat:@"%@",dic[@"errno"]];
        if ([errnoStr isEqualToString:@"0"]) {

            [NSUSER_DEFAULT setObject:dic[@"data"][@"nickname"] forKey:@"name"];
            // 初始头像
            [NSUSER_DEFAULT setObject:dic[@"data"][@"face"] forKey:@"face"];
            [NSUSER_DEFAULT setObject:dic[@"data"][@"signature"] forKey:@"signature"];
            [NSUSER_DEFAULT synchronize];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeInfo" object:nil];
            
        } else {
        
        }
    } failure:^(NSError *error) {
        
    }];
}

// 修改密码
- (void)getChangePwdId:(NSString *)Id password:(NSString *)password
{
    [HttpNetworkingTool post:[NSString stringWithFormat:@"%@api/GameApi/editmyself",DEFAULT_SERVER_IP] params:@{@"id":Id,@"password":password} success:^(id responseObj) {
        
        NSDictionary *dic = responseObj;
        if ([[NSString stringWithFormat:@"%@",dic[@"errno"]] isEqualToString:@"0"]) {
            _newsPwd.text = nil;
            [MBProgressHUD showHUDWithMeg:dic[@"errmsg"] toView:_background];
        } else {
            [MBProgressHUD showHUDWithMeg:dic[@"errmsg"] toView:_background];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

// 修改头像
- (void)tapIconAction
{
    [self changeHeadImage];
}


#pragma mark-弹出alterView,并且可根据7或者8系统经行自定义
// 更换头像
-(void)changeHeadImage
{
    //让屏幕可以旋转
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeRotate" object:@"0"];
    [self.view endEditing: YES ];
    if (!IS_IOS8) {
        UIActionSheet *actionSheet  = [[UIActionSheet alloc] initWithTitle:nil delegate: self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
        [actionSheet showInView:self.background];
        
        
    }else{
        
        UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil
                                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拍照"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                        
                                                            [self takePhoto];
                                                            
                                                        }];
        [actionSheetController addAction:action0];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"从相册选择"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                         
                                                           [self localPhoto];
                                                       }];
        
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {}];
        
        [actionSheetController addAction:action];
        [actionSheetController addAction:actionCancel];
        [actionSheetController.view setTintColor:[UIColor blackColor]];
        [self presentViewController:actionSheetController animated:YES completion:nil];
        
    }
}

//actionSheet  delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            // 拍照
        {
            [self takePhoto];
            
          
        }
            break;
        case 1:
            // 从相册上传
        {
            
            [self localPhoto];
           
        }
            break;
        default:
            break;
    }
}

//适应iOS7系统
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    for (UIView *subView in actionSheet.subviews) {
        
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)subView;
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:18];
        }
    }
}

#pragma mark-头像上传
-(void)takePhoto{
    //判断拍照功能是否打开
    AVAuthorizationStatus authStatus=[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus== AVAuthorizationStatusDenied) {
        
        UIAlertView*myAlert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请在(设置-隐私-相机)中允许VR世界使用相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [myAlert show];
        return;
    }else{
        //判断是否有摄像头
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        
        if (!isCamera) {
            //提示无摄像头
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"此设备没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
            return;
        }else{
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing=YES;
            
            imagePicker.delegate=self;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        
    }
    
}

-(void)localPhoto{
    
    //从相册选择照片
    ALAuthorizationStatus authStatus=[ALAssetsLibrary authorizationStatus];
    /*
     ALAuthorizationStatusNotDetermined = 0, 用户尚未做出了选择这个应用程序的问候
     ALAuthorizationStatusRestricted,        此应用程序没有被授权访问的照片数据。可能是家长控制权限。
     ALAuthorizationStatusDenied,
     用户已经明确否认了这一照片数据的应用程序访问.
     ALAuthorizationStatusAuthorized         用户已授权应用访问照片数据.
     */
    
    if (authStatus==ALAuthorizationStatusRestricted||authStatus==ALAuthorizationStatusDenied) {
        
        UIAlertView*myAlert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请在(设置-隐私-照片)中允许VR世界使用照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [myAlert show];
        return;
    }
    
    //弹出相册选取控制器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.allowsEditing=YES;
    imagePicker.delegate=self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

#pragma mark - 调用系统摄像头和相册
// 打开相机
- (void)openCamera {
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        [MBProgressHUD showError:@"没有摄像头" toView:self.view];
        return ;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;//动画效果
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// 打开相册
- (void)openPics
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 让屏幕旋转失效
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeRotate" object:@"1"];
    
    UIImage *imagePicker = [info objectForKey:UIImagePickerControllerEditedImage];
    self.pickImage=imagePicker;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *originImage = self.pickImage;
    
    NSData *data =UIImageJPEGRepresentation(originImage, 0.1);
    NSString *baseStr =[GTMBase64 stringByEncodingData:data];
    self.base64Str=baseStr;
    [self getChangeIconUrlID:[NSUSER_DEFAULT objectForKey:@"id"] face:self.base64Str];
    
}

// 修改头像接口
- (void)getChangeIconUrlID:(NSString *)ID face:(NSString *)face
{
    [HttpNetworkingTool post:[NSString stringWithFormat:@"%@api/GameApi/face",DEFAULT_SERVER_IP] params:@{@"id":ID,@"face":face} success:^(id responseObj) {
        NSDictionary *dic = responseObj;
        if ([[NSString stringWithFormat:@"%@",dic[@"errno"]]  isEqualToString:@"0"]) {
            [self getLoginUrlAccount:[NSUSER_DEFAULT objectForKey:@"userTel"] pwd:[NSUSER_DEFAULT objectForKey:@"passWord"] type:@"2"];
            [MBProgressHUD showSuccess:dic[@"errmsg"] toView:self.view];
            
        } else {
            [MBProgressHUD showSuccess:dic[@"errmsg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)changeInfoAction
{
    NSString *faceStr = [NSUSER_DEFAULT objectForKey:@"face"];
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",faceStr]]];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenBase" object:nil];
}

// 移除通知
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

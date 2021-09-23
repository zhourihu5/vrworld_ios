//
//  VersionInfoViewController.m
//  VR_world
//
//  Created by davysen on 16/3/28.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "VersionInfoViewController.h"
#import "VersionInfoCell.h"
#import "sys/sysctl.h"

@interface VersionInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UIImageView *NavBackground;
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *qrCode;
@property (nonatomic, strong) UILabel *rightTitle;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation VersionInfoViewController

static NSString *cellID = @"cellID";
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
    title.text = @"版本信息";
    title.textColor = [UIColor whiteColor];
    [_NavBackground addSubview:title];
    title.textAlignment = NSTextAlignmentCenter;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, _NavBackground.bottom, SCREEN_WIDTH / 5.242, SCREEN_HEIGHT)];
    leftView.backgroundColor = UICOLOR_RGB(4, 20, 44);
    [self.view addSubview:leftView];
    UILabel *leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH / 5.242, 20)];
    leftTitle.text = @"关于我们";
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
    _rightTitle.text = @"关于我们\t";
    _rightTitle.textAlignment = NSTextAlignmentRight;
    _rightTitle.layer.cornerRadius = 13;
    _rightTitle.layer.masksToBounds = YES;
    _rightTitle.textColor = [UIColor whiteColor];
    [_rightView addSubview:_rightTitle];
    
    _qrCode = [[UIImageView alloc] initWithFrame:CGRectMake(20, _rightTitle.bottom + 30, SCREEN_WIDTH / 5, SCREEN_WIDTH / 5)];
    UIImage *qrImg = [UIImage imageNamed:@"erweima.jpg"];
    _qrCode.image = qrImg;
    [_rightView addSubview:_qrCode];

 
    [self drawTableView];
}

- (void)drawTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(_qrCode.right + 10, _rightTitle.bottom + 20, 230, 170)];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_rightView addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 26;
    } else {
        return 16;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VersionInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[VersionInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.labelType1.text = @"当前版本:1.0";
    } else if (indexPath.row == 1) {
        cell.labelType4.text = @"本机型号:";
        cell.labelType5.textColor = [UIColor whiteColor];

        NSString *dev =  [self doDevicePlatform];
        cell.labelType5.text = dev;
        
    } else if (indexPath.row == 2) {
        cell.labelType1.font = [UIFont systemFontOfSize:15];
        cell.labelType1.text = @"版权:北京极维客科技有限公司";
    } else if (indexPath.row == 3) {
        cell.labelType1.text = @"移动虚拟现实一站式平台";
    } else if (indexPath.row == 4) {
        cell.labelType2.text = @"官网:";
        // 字体加下划线
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"www.gevek.com"];
        NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        cell.labelType3.attributedText = content;
    } else if (indexPath.row == 5) {
        cell.labelType2.text = @"论坛:";
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"bbs.gevek.com"];
        NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        cell.labelType3.attributedText = content;
    } else if (indexPath.row == 6) {
        cell.labelType2.text = @"邮箱:";
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"contac@gevek.com"];
        NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        cell.labelType3.attributedText = content;
    } else if (indexPath.row == 7) {
        cell.labelType4.text = @"客服电话:";
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"010-56197811"];
        NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        cell.labelType5.attributedText = content;
    } else if (indexPath.row == 8) {
        cell.labelType1.text = @"微信公众号:gevek_club";
    } else if (indexPath.row == 9) {
        cell.labelType1.text = @"QQ群号码:251979329";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        if(indexPath.row == 4){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.gevek.com"]];
        } else if (indexPath.row == 5) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://bbs.gevek.com"]];
        } else if (indexPath.row == 6) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://contac@gevek.com"]];
        } else if (indexPath.row == 7) {
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"拨打电话" message:@"010-56197811" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alter show];
        }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://010-56197811"]];
}


// 识别手机型号
- (NSString*) doDevicePlatform
{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) {
        
        platform = @"iPhone";
        
    } else if ([platform isEqualToString:@"iPhone1,2"]) {
        
        platform = @"iPhone 3G";
        
    } else if ([platform isEqualToString:@"iPhone2,1"]) {
        
        platform = @"iPhone 3GS";
        
    } else if ([platform isEqualToString:@"iPhone3,1"]||[platform isEqualToString:@"iPhone3,2"]||[platform isEqualToString:@"iPhone3,3"]) {
        
        platform = @"iPhone 4";
        
    } else if ([platform isEqualToString:@"iPhone4,1"]) {
        
        platform = @"iPhone 4S";
        
    } else if ([platform isEqualToString:@"iPhone5,1"]||[platform isEqualToString:@"iPhone5,2"]) {
    
        platform = @"iPhone 5";

    }else if ([platform isEqualToString:@"iPhone5,3"]||[platform isEqualToString:@"iPhone5,4"]) {
        
        platform = @"iPhone 5C";
        
    }else if ([platform isEqualToString:@"iPhone6,2"]||[platform isEqualToString:@"iPhone6,1"]) {
        
        platform = @"iPhone 5S";
        
    }else if ([platform isEqualToString:@"iPhone7,1"]||[platform isEqualToString:@"iPhone7,2"]) {
        
        platform = @"iPhone 6";
        
    }else if ([platform isEqualToString:@"iPhone7,3"]||[platform isEqualToString:@"iPhone7,4"]) {
        
        platform = @"iPhone 6s";
        
    }else if ([platform isEqualToString:@"iPhone8,1"]||[platform isEqualToString:@"iPhone8,2"]) {
        
        platform = @"iPhone 6plus";
        
    }else if ([platform isEqualToString:@"iPhone8,3"]||[platform isEqualToString:@"iPhone8,4"]) {
        
        platform = @"iPhone 6s";
        
    }else if ([platform isEqualToString:@"iPod4,1"]) {
        
        platform = @"iPod touch 4";
        
    }else if ([platform isEqualToString:@"iPod5,1"]) {
        
        platform = @"iPod touch 5";
        
    }else if ([platform isEqualToString:@"iPod3,1"]) {
        
        platform = @"iPod touch 3";
        
    }else if ([platform isEqualToString:@"iPod2,1"]) {
        
        platform = @"iPod touch 2";
        
    }else if ([platform isEqualToString:@"iPod1,1"]) {
        
        platform = @"iPod touch";
        
    } else if ([platform isEqualToString:@"iPad3,2"]||[platform isEqualToString:@"iPad3,1"]) {
        
        platform = @"iPad 3";
        
    } else if ([platform isEqualToString:@"iPad2,2"]||[platform isEqualToString:@"iPad2,1"]||[platform isEqualToString:@"iPad2,3"]||[platform isEqualToString:@"iPad2,4"]) {
        
        platform = @"iPad 2";
        
    }else if ([platform isEqualToString:@"iPad1,1"]) {
        
        platform = @"iPad 1";
        
    }else if ([platform isEqualToString:@"iPad2,5"]||[platform isEqualToString:@"iPad2,6"]||[platform isEqualToString:@"iPad2,7"]) {
        
        platform = @"ipad mini";
    
    } else if ([platform isEqualToString:@"iPad3,3"]||[platform isEqualToString:@"iPad3,4"]||[platform isEqualToString:@"iPad3,5"]||[platform isEqualToString:@"iPad3,6"]) {
        
        platform = @"ipad 3";
        
    }
    return platform;
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

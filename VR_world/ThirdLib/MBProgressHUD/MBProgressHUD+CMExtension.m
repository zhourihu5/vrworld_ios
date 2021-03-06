//
//  MBProgressHUD+CMExtension.m
//  ITON
//
//  Created by WangZHW on 15/10/26.
//  Copyright © 2015年 heyixun-wd. All rights reserved.
//

#import "MBProgressHUD+CMExtension.h"

@implementation MBProgressHUD (CMExtension)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [MBProgressHUD showHUDWithMeg:success
                           toView:view];
}

+ (void)showError:(NSString *)error toView:(UIView *)view{
    [MBProgressHUD showHUDWithMeg:error
                           toView:view];
}

+ (void)showHUDWithMeg:(NSString *)msg toView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
    MBProgressHUD* hud   = [MBProgressHUD showHUDAddedTo:view
                                              animated:YES];
    hud.detailsLabelText = msg;
    hud.mode             = MBProgressHUDModeText;
    [hud hide:YES afterDelay:1];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view         = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText                 = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground             = NO;
    return hud;
}

+ (MBProgressHUD *)showHUDtoView:(UIView *)view{
    if (view == nil) view         = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground             = NO;
//    [APP_DELEGATE.window.userInteractionEnabled = NO;
    return hud;
}

+ (void)hideAllHUDForView:(UIView *)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
//    APP_DELEGATE.window.userInteractionEnabled = YES;
}
@end

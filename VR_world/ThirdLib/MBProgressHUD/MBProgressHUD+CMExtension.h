//
//  MBProgressHUD+CMExtension.h
//  ITON
//
//  Created by WangZHW on 15/10/26.
//  Copyright © 2015年 heyixun-wd. All rights reserved.
//

#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface MBProgressHUD (CMExtension)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showHUDWithMeg:(NSString *)msg toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (MBProgressHUD *)showHUDtoView:(UIView *)view;

+ (void)hideAllHUDForView:(UIView *)view;

@end

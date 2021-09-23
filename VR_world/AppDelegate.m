//
//  AppDelegate.m
//  VR_world
//
//  Created by XZB on 16/3/14.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "BaiduMobStat.h"

@interface AppDelegate ()

// 打开相册竖屏
@property NSUInteger MYInterfaceOrientationMask;
//@property (nonatomic,strong) UIApplication *app;

@end

@implementation AppDelegate

/**
 *  初始化百度统计SDK
 */
- (void)startBaiduMobStat {
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    // 此处(startWithAppId之前)可以设置初始化的可选参数，具体有哪些参数，可详见BaiduMobStat.h文件，例如：
    statTracker.shortAppVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    statTracker.enableDebugOn = YES;
    
    [statTracker startWithAppId:@"9f8454957b"]; // 设置您在mtj网站上添加的app的appkey,此处AppId即为应用的appKey
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 初始化百度统计SDK
    [self startBaiduMobStat];
    
    //初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:@"10c221de406f0"
             withSecret:@"9030599325c1e4e8b93af5e4f30852e4"];
    
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    _MYInterfaceOrientationMask=UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationLandscapeLeft;
    
    
    // 是否竖屏
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeRotate:) name:@"changeRotate" object:@"0"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeRotate:) name:@"changeRotate" object:@"1"];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor blackColor];
    
    return YES;
}
//发通知要执行的方法（打开相册）
- (void)changeRotate:(NSNotification *)noti{
    if ([noti.object isEqualToString:@"1"]) {
        _MYInterfaceOrientationMask=UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationLandscapeLeft;
    }else{
        _MYInterfaceOrientationMask=UIInterfaceOrientationMaskAll;
    }
//    [self application:_app supportedInterfaceOrientationsForWindow:self.window];
}

#if __IPAD_OS_VERSION_MAX_ALLOWED >= __IPAD_6_0
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
//    _app=application;
//    self.window=window;
    
   return _MYInterfaceOrientationMask;
    return 0;
}
#endif


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

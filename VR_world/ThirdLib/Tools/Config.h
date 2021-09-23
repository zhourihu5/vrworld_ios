//
//  Config.h
//  DaiShuPhone
//
//  Created by Tony on 15/7/8.
//  Copyright (c) 2015年 XZB. All rights reserved.
//

#ifndef DaiShuPhone_Config_h
#define DaiShuPhone_Config_h

//保存用户名密码
#define UserPhone @"UserPhone"
#define UserPWD   @"UserPWD"

//#import "YProgressHUD.h"
//#import "JsonToDic.h"
//#import "RLHttpRequest.h"


/**
 *  NSUSER_DEFAULT
 */
#define NSUSER_DEFAULT [NSUserDefaults standardUserDefaults]

/**
 *  [UIImage imageNamed:(name)]
 */
#define UIIMAGE_NAMED(name) [UIImage imageNamed:(name)]

/**
 *  r g b 颜色
 */
#define UICOLOR_RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

/**
 *  r g b a 颜色
 */
#define RGB_COLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

/**
 *  rgb颜色转换（16进制->UIColor）
 */
#define UICOLOR_FROM_HEX(hex_value) [UIColor colorWithRed:((float)((hex_value & 0xFF0000) >> 16))/255.0 green:((float)((hex_value & 0xFF00) >> 8))/255.0 blue:((float)(hex_value & 0xFF))/255.0 alpha:1.0]

/**
 *  屏幕宽度
 */
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

/**
 *  屏幕高度
 */
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_HEIGHTLAYER ((SCREEN_HEIGHT - 64 - 49))
/**
 *  是否是ios7及其以后版本
 */
#define IS_IOS7_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

/**
 *  [NSString stringWithFormat:@"%@",(a)]
 */
#define NSSTRING_FROM_OBJ(a) ((a) ? [NSString stringWithFormat:@"%@",(a)] : @"")

/**
 *  当一个对象为 nil 时，返回 @""
 */
#define NSSTRING_EXCLUDE_NIL(str) (str && [str isKindOfClass:[NSString class]] ?str:@"")

#define IS_SAVE_USERNAME_AND_PWD           @"IS_SAVE_USERNAME_AND_PWD"
/**
 *  用户名
 */
#define USER_NAME                          @"USER_NAME"
/**
 *  密码
 */
#define PASS_WORD                          @"PASS_WORD"
/**
 *  服务器ip
 */
#define SERVER_IP                          @"SERVER_IP"
/**
 *  服务器端口
 */
#define SERVER_PORT                        @"SERVER_PORT"



/******************************************** http  *******************************************/
/**
 *  默认服务器ip
 */
/*
juyi
115.28.178.93:8280
 */
#define DEFAULT_SERVER_IP  @"http://www.gevek.com/"
// 客户139.129.119.155
/**
 *  默认服务器端口
 */
#define DEFAULT_SERVER_PORT         @"82"
/**
 *  服务基本请求地址
 */
#define BASE_URL                        [@"http://" stringByAppendingFormat:@"%@/",DEFAULT_SERVER_IP]

/**
 图片基本请求

 **/

#define BASE_IMAGE_URL                        [@"http://" stringByAppendingFormat:@"%@/kangaroo/",DEFAULT_SERVER_IP]




//#define URL_LOGIN (mobilePhone,passWord)  [NSString stringWithFormat:@"%@memberLogin.do?mobilephone=%@&password=%@",HOST_EHIVE,mobilePhone,passWord]
///**
// *  修改密码
// */
//#define URL_CHANGE_PASSWORD                [HOST_EHIVE stringByAppendingString:@"userManage.spr?method=updateStaffPwd"]
///**
// *  个人中心
// */
//#define URL_Person    [HOST_EHIVE stringByAppendingString:@"userManage.spr?method=qryPersonInfo"]
///**
// * 用户头像
// */
//#define URL_ICONPHOTO    [HOST_EHIVE stringByAppendingString:@"upload.spj?method=uploadPhoto"]
///**
// * 工单图片
// */
//#define URL_ORDERPHOTO    [HOST_EHIVE stringByAppendingString:@"upload.spj?method=uploadDevPhoto"]


#endif

//
//  StringConstants.h
//  RenRenApp
//
//  Created by RichyLeo on 15/8/31.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#ifndef RenRenApp_StringConstants_h
#define RenRenApp_StringConstants_h

// 导航条的高度
#define NAV_BAR_HEIGHT  64
// Tabbar的高度
#define TABBAR_HEIGHT   49

#define CELL_HEIGHT     80

// 边距设置
#define GAP 20

// 获取屏幕的宽高
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

// RGB色值
#define RGB_COLOR(r, g, b, al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]

// 获取设备版本
#define IOS_7 [[UIDevice currentDevice].systemVersion floatValue] >= 7.0

/**
 *  所有唯一标识
 */
#define APP_LIST_CELL     @"APP_LIST_CELL"
#define CLASSY_LIST_CELL    @"CLASSY_LIST_CELL"

// 其他设置
// 字体设置
#define FontBold(x)     [UIFont boldSystemFontOfSize:x]
#define FontSystem(x)   [UIFont systemFontOfSize:x]
// 默认图片加载
#define DefaultImage    [UIImage imageNamed:@"icon.png"]
// Model中NSString属性设置
#define PropertyString(str) @property (nonatomic, copy) NSString * str;

/**
 *  数据存储  key值
 */
// 详情的数据
//#define KEY_DETAIL_INFO     @"KEY_DETAIL_INFO"


/**
 *  缓存图片路径的设置
 */
#define IMAGE_CACHE    [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"imageCache"]
#define IMAGE_ICON  [IMAGE_CACHE stringByAppendingPathComponent:@"icon"]
#define IMAGE_SMALL  [IMAGE_CACHE stringByAppendingPathComponent:@"small"]
#define IMAGE_BIG  [IMAGE_CACHE stringByAppendingPathComponent:@"big"]

//标记第一次进入app
#define ITONFirstEnterKey @"first_enter"
//标记是否是第一次绑定
#define ITONFirstBindMifiKey @"first_bind"

#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define KEYWINDOW [UIApplication sharedApplication].keyWindow
#define Tab_Bar (UITabBarController *)(KEYWINDOW.rootViewController)
#define NavigaController (UINavigationController *)APP_DELEGATE.naviController
#define MIFI_model [CMMifiModel shareMifiModel]


#define KCNSSTRING_ISEMPTY(str) (str == nil || [str isEqual:[NSNull null]] || str.length <= 0)

#endif

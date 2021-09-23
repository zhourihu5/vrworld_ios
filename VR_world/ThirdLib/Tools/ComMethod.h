//
//  ComMethod.h
//  ITON
//
//  Created by 和易讯 on 14-8-6.
//  Copyright (c) 2014年 heyixun-wd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+MakeSimpleColorImage.h"
//#import "ASIHTTPRequest/Reachability.h"
//#import "ASIAuthenticationDialog.h"
@interface ComMethod : NSObject

+(UIButton*)createButtonWithFrame:(CGRect)frame normalImg:(UIImage*)norImg selectImg:(UIImage*)selectImg;

+(UIImageView*)createImgViewWithFrame:(CGRect)frame image:(UIImage*)img;

+(UILabel*)createLabelWithFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)color font:(CGFloat)font textAligment:(NSTextAlignment)aligment;

+(UITextField*)createTextFieldWithFrame:(CGRect)frame textColor:(UIColor*)color placeHolder:(NSString*)holdStr tag:(int)tag delegate:(id)delegate;

//获取一个字符串的宽和高
+(CGSize)getStringLenHeight:(NSString*)str withFontSize:(float)fontSize;

+(UILabel*)getAutomaticWarpLabel:(NSString*)str withFrame:(CGRect)frame fontSize:(float)fSize;

////在图片上画文字
//+(UIImage*)drawWordOnImage:(NSString*)text fontSize:(float)size;



//判断字符串是否为空
+(BOOL)isBlankString:(NSString*)string;

//UUID
+(NSString*)getDeviceName;

//获取app的版本号
+(NSString*)getAppVersion;

//
////是否wifi
//+(BOOL)isEnableWifi;
//
////是否3G网络
//+(BOOL)isEnable3G;
//
////是否没有网络连接
//+(BOOL)isEnableNet;


/** label的宽高自适应   lan*/
+ (CGSize)currentSize:(NSString *)labelText and:(CGFloat)font;



@end

@interface UIColor (HexStringColor)

+(UIColor *) colorWithHexString: (NSString *)color;

@end

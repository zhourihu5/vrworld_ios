//
//  Tools.h
//  RenRenApp
//
//  Created by RichyLeo on 15/8/31.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject

/**
 *  通过文件路径加载图片
 *  该方法加载图片优势：不会将图片加到内存缓存中（适用类型：较大图片的处理）
 *
 *  @param imgName 图片名称（带扩展名）eg：btn_login.png
 *
 *  @return 返回图片对象
 */
+(UIImage *)imageWithName:(NSString *)imgName;

// 创建UITextFiled
+(UITextField *)createTextFieldWithFrame:(CGRect)frame
                             placeHolder:(NSString *)placeHolderStr
                             borderStyle:(UITextBorderStyle)style
                           textAlignment:(NSTextAlignment)alignment
                                    font:(UIFont *)font
                                isSecure:(BOOL)isSecure;
// 创建一个按钮 （以图片展现）
+(UIButton *)createButtonNormalImage:(NSString *)normalImageName selectedImage:(NSString *)selectImageName tag:(NSUInteger)tag addTarget:(id)target action:(SEL)action;

// 创建一个按钮 （以文字形式展现，带背景）
//+(UIButton *)createButtonBgImage:(NSString *)imageName title:(NSString *)title tag:(NSInteger)tag target:(id)target action:(SEL)action;

// 创建UILabel
+(UILabel *)createLabelWithFrame:(CGRect)frame textContent:(NSString *)text withFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)align;

// 创建AlertView 展示信息
+(void)showAlertWithMessage:(NSString *)msg;

/**
 *  服务端null空值的处理
 */
+(id)getValueExceptNull:(id)value;

// 判断本地是否有图片缓存
+(BOOL)isImageCachedRootPath:(NSString *)rootPath imageUrl:(NSString *)url;

// 缓存图片
+(void)cacheImage:(UIImage *)image imagePath:(NSString *)imgPath;


@end

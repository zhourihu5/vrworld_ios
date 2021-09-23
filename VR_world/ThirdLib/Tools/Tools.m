//
//  Tools.m
//  RenRenApp
//
//  Created by RichyLeo on 15/8/31.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import "Tools.h"

@implementation Tools

/**
 *  通过文件路径加载图片
 *  该方法加载图片优势：不会将图片加到内存缓存中（适用类型：较大图片的处理）
 *
 *  @param imgName 图片名称（带扩展名）eg：btn_login.png
 *
 *  @return 返回图片对象
 */

+(UIImage *)imageWithName:(NSString *)imgName
{
    if(imgName){
        NSString * path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
        UIImage * image = [UIImage imageWithContentsOfFile:path];
        return image;
    }
    
    return nil;
}

// 创建一个按钮 （以图片展现）
+(UIButton *)createButtonNormalImage:(NSString *)normalImageName selectedImage:(NSString *)selectImageName tag:(NSUInteger)tag addTarget:(id)target action:(SEL)action
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateHighlighted];
    btn.tag = tag;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

// 创建一个按钮 （以文字形式展现，带背景）
//+(UIButton *)createButtonBgImage:(NSString *)imageName title:(NSString *)title tag:(NSInteger)tag target:(id)target action:(SEL)action
//{
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    btn.titleLabel.font = FontSystem(24.0f);
//    btn.tag = tag;
//    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    
//    return btn;
//}

// 创建UILabel
+(UILabel *)createLabelWithFrame:(CGRect)frame textContent:(NSString *)text withFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)align
{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.textColor = color;
    label.textAlignment = align;
    label.text = text;
    
    return label;
}

+(UITextField *)createTextFieldWithFrame:(CGRect)frame
                             placeHolder:(NSString *)placeHolderStr
                             borderStyle:(UITextBorderStyle)style
                           textAlignment:(NSTextAlignment)alignment
                                    font:(UIFont *)font
                                isSecure:(BOOL)isSecure
{
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeHolderStr;
    textField.borderStyle = style;
    textField.textAlignment = alignment;
    textField.font = font;
    if(isSecure){
        textField.secureTextEntry = YES;
    }
    
    return textField;
}

+(void)showAlertWithMessage:(NSString *)msg
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

/**
 *  服务端null空值的处理
 */
+(id)getValueExceptNull:(id)value
{
    return [value isEqual:[NSNull null]] ? @"aaaaa" : value;
}

// 判断本地是否有图片缓存
//+(BOOL)isImageCachedRootPath:(NSString *)rootPath imageUrl:(NSString *)url
//{
//    NSFileManager * fm = [NSFileManager defaultManager];
//    NSString * imagePath = [rootPath stringByAppendingPathComponent:[url MD5Hash]];
//    if([fm fileExistsAtPath:imagePath]){
//        // 存在
//        return YES;
//    }
//    return NO;
//}

// 缓存图片
+(void)cacheImage:(UIImage *)image imagePath:(NSString *)imgPath
{
    NSFileManager * fm = [NSFileManager defaultManager];
    NSData * data = UIImagePNGRepresentation(image);
    if(![fm fileExistsAtPath:imgPath]){
        [fm createFileAtPath:imgPath contents:data attributes:nil];
    }
}



@end

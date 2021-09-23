//
//  ComMethod.m
//  ITON
//
//  Created by 和易讯 on 14-8-6.
//  Copyright (c) 2014年 heyixun-wd. All rights reserved.
//

#import "ComMethod.h"
#import "StringConstants.h"
@implementation ComMethod


+(UIButton*)createButtonWithFrame:(CGRect)frame normalImg:(UIImage*)norImg selectImg:(UIImage*)selectImg
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame))];
    [btn setUserInteractionEnabled:YES];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:norImg forState:UIControlStateNormal];
    [btn setImage:selectImg forState:UIControlStateHighlighted];
   [btn setImage:selectImg forState:UIControlStateSelected];
    btn.adjustsImageWhenHighlighted = NO;
    return btn;
}


+(UIImageView*)createImgViewWithFrame:(CGRect)frame image:(UIImage*)img
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame))];
    [imgView setUserInteractionEnabled:YES];
    [imgView setBackgroundColor:[UIColor clearColor]];
    [imgView setImage:img];
    return imgView;
}

+(UILabel*)createLabelWithFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)color font:(CGFloat)font textAligment:(NSTextAlignment)aligment
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame))];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:color];
    [label setFont:[UIFont systemFontOfSize:font]];
    [label setTextAlignment:aligment];
    [label setText:text];
//    [label setAdjustsFontSizeToFitWidth:YES];
    [label setUserInteractionEnabled:YES];
    return label;
}



+(UITextField*)createTextFieldWithFrame:(CGRect)frame textColor:(UIColor*)color placeHolder:(NSString*)holdStr tag:(int)tag delegate:(id)delegate
{
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame))];
    [tf setTextColor:color];
    [tf setUserInteractionEnabled:YES];
    [tf setBorderStyle:UITextBorderStyleNone];
    [tf setClearButtonMode:UITextFieldViewModeWhileEditing];
    [tf setTag:tag];
    [tf setPlaceholder:holdStr];
    [tf setDelegate:delegate];
    return tf;
}

+(CGSize)getStringLenHeight:(NSString*)str withFontSize:(float)fontSize
{
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:fontSize]];
    return size;
}

+(UILabel*)getAutomaticWarpLabel:(NSString*)str withFrame:(CGRect)frame fontSize:(float)fSize
{
    UILabel *label;
    CGSize size = [self getStringLenHeight:str withFontSize:fSize];
    if (size.width > frame.size.width) {
        //换行
        label = [[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,[self getTextHeight:str withWidth:frame.size.width])];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 3;
        label.text = str;
    }
    
    return label;
}

//获取文字内容的总高度
+(NSInteger)getTextHeight:(NSString*)string withWidth:(NSInteger)width
{
    NSInteger lenNumber = string.length;
    NSString *aStr = [string substringToIndex:1];
   
    CGSize aStrSize = [aStr sizeWithFont:[UIFont systemFontOfSize:13]];
    //计算字符串的总长
    NSInteger lenLong = aStrSize.width * lenNumber;
    //计算总共有多少行
    NSInteger hang = (lenLong / width) + 2;
    //计算有总高度
    return aStrSize.height *hang;
}

//判断字符串是否为空
+(BOOL)isBlankString:(NSString*)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

+(NSString*)getDeviceName
{
    return [[[UIDevice currentDevice] name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - 获取app的基本信息
//获取app的版本号
+(NSString*)getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}


#pragma mark - 检查网络连接状态
//是否wifi
//+(BOOL)isEnableWifi
//{
//    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] == ReachableViaWiFi);
//}
//
////是否3G网络
//+(BOOL)isEnable3G
//{
//    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWWAN);
//}
//
////是否没有网络连接
//+(BOOL)isEnableNet
//{
//    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable);
//
//}


+ (CGSize)currentSize:(NSString *)labelText and:(CGFloat)font{
    CGSize size;
    CGFloat version = [[UIDevice currentDevice].systemVersion floatValue];
    if (version>=7.0) {
        //创建一个带有字体属性的字典
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil];
        //效果与iOS7之前的方法一致
        size = [labelText boundingRectWithSize:CGSizeMake(SCREEN_WIDTH,999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    }else{
        size = [labelText sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(SCREEN_WIDTH, 999) lineBreakMode:NSLineBreakByCharWrapping];
    }
    return size;
}



@end


@implementation UIColor (HexStringColor)

+(UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}









@end



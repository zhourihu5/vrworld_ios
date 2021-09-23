//
//  UIImage+MakeSimpleColorImage.m
//  ITON
//
//  Created by 和易讯 on 14-7-31.
//  Copyright (c) 2014年 heyixun-wd. All rights reserved.
//

#import "UIImage+MakeSimpleColorImage.h"

@implementation UIImage (MakeSimpleColorImage)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage*)imageWithBundleImageNamed:(NSString*)imageName
{
    NSString *imgFile = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:imgFile];
    
    
    
    return image;
}

@end

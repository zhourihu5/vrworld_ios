//
//  UIImage+MakeSimpleColorImage.h
//  ITON
//
//  Created by 和易讯 on 14-7-31.
//  Copyright (c) 2014年 heyixun-wd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MakeSimpleColorImage)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  使用该方法可以内存缓存图片，造成内存的增长
 *
 *  @param imageName 图片文件的名字，包括图片的后缀名（.png,.jpg,etc）
 *
 *  @return 图片对象
 */
+ (UIImage*)imageWithBundleImageNamed:(NSString*)imageName;

@end

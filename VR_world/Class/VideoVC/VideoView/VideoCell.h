//
//  VideoCell.h
//  VR_world
//
//  Created by XZB on 16/3/15.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

@interface VideoCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *img; // 图片
@property (nonatomic, strong) UILabel *title; // 电影名字

- (void)setVideoModel:(VideoModel *)videoModel;

@end

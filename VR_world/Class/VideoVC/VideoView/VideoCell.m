//
//  VideoCell.m
//  VR_world
//
//  Created by XZB on 16/3/15.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self drawCollectionViewCell];
    }
    return self;
}

- (void)drawCollectionViewCell
{
    UIView *video = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 4 - 25, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 4 - 25 + SCREEN_HEIGHT / 6.9)];
    [self.contentView addSubview:video];
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 4 - 25, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 4 - 25 + 60 - 20)];
    UIImage *img = [UIImage imageNamed:@""];
    _img.image = img;
    _img.layer.masksToBounds = YES;
    _img.layer.cornerRadius = 5;
    [video addSubview:_img];
    
    // 电影名字
    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 4 - 25 + 60 - 15, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 4 - 25, 20)];
    _title.text = @"text";
    _title.textColor = [UIColor whiteColor];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.font = [UIFont systemFontOfSize:SCREEN_WIDTH / 49];
    [video addSubview:_title];
}

- (void)setVideoModel:(VideoModel *)videoModel
{
    // 电影名字
    self.title.text = [NSString stringWithFormat:@"%@",videoModel.title];
    // 电影图片
    NSString *imgUrl = [NSString stringWithFormat:@"%@",videoModel.icon];
    [self.img sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}

@end

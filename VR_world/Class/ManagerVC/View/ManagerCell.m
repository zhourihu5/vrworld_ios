//
//  ManagerCell.m
//  VR_world
//
//  Created by davysen on 16/3/25.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "ManagerCell.h"

@implementation ManagerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self drawCellView];
    }
    return self;
}

- (void)drawCellView
{
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 2 - 15, SCREEN_HEIGHT / 5.175)];
    UIImage *img = [UIImage imageNamed:@"矩形"];
    background.image = img;
    [self.contentView addSubview:background];
    
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, SCREEN_HEIGHT / 5.175 - 40, SCREEN_HEIGHT / 5.175 - 40)];
    [self.contentView addSubview:_icon];
    
    _title = [[UILabel alloc] initWithFrame:CGRectMake(_icon.right + 10, 0, 120, SCREEN_HEIGHT / 5.175)];
    _title.textColor = [UIColor whiteColor];
    _title.font = [UIFont systemFontOfSize:SCREEN_HEIGHT / 27.6];
    [background addSubview:_title];
    
}





@end

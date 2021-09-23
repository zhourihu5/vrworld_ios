//
//  VersionInfoCell.m
//  VR_world
//
//  Created by davysen on 16/3/28.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "VersionInfoCell.h"

@implementation VersionInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self drawCell];
    }
    return self;
}

- (void)drawCell
{
    self.contentView.backgroundColor = UICOLOR_RGB(4, 20, 44);
    _labelType1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 14)];
    _labelType1.textColor = [UIColor whiteColor];
    _labelType1.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_labelType1];
    
    _labelType2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 16)];
    _labelType2.textColor = [UIColor whiteColor];
    _labelType2.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_labelType2];
    
    _labelType3 = [[UILabel alloc] initWithFrame:CGRectMake(_labelType2.right, 0, 160, 16)];
    _labelType3.textColor = UICOLOR_FROM_HEX(0x01cabe);
    _labelType3.textAlignment = NSTextAlignmentLeft;
    _labelType3.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_labelType3];
    
    _labelType4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 16)];
    _labelType4.font = [UIFont systemFontOfSize:13];
    _labelType4.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_labelType4];
    
    _labelType5 = [[UILabel alloc] initWithFrame:CGRectMake(_labelType4.right, 0, 140, 16)];
    _labelType5.textColor = UICOLOR_FROM_HEX(0x01cabe);
    _labelType5.textAlignment = NSTextAlignmentLeft;
    _labelType5.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_labelType5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

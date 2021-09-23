//
//  CustomLoadingView.m
//  GroupMe
//
//  Created by shorigo on 13-5-8.
//  Copyright (c) 2013年 shori. All rights reserved.
//

#import "CustomLoadingView.h"

@implementation CustomLoadingView
@synthesize tittle,active;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithLoadingView];
    }
    return self;
}

-(void)initWithLoadingView
{
    self.backgroundColor = [UIColor clearColor];
    
    /*
    UIView * bgView = [[UIView alloc] initWithFrame:self.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.6;
    [self addSubview:bgView];
    */
    
    UIView * bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
    bgView2.layer.cornerRadius = 5.0f;
    bgView2.layer.masksToBounds = YES;
    bgView2.layer.backgroundColor = [[UIColor blackColor] CGColor];
    bgView2.backgroundColor = [UIColor blackColor];
    bgView2.alpha=0.5;
    [self addSubview:bgView2];
    
    
    active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [active startAnimating];
    //active.backgroundColor=[UIColor redColor];
    active.frame = CGRectMake((CGRectGetWidth(bgView2.frame)-35)/2,(CGRectGetHeight(bgView2.frame)-40)/2, 35, 30);
    [bgView2 addSubview:active];
    
    
    tittle = [[UILabel alloc] initWithFrame:CGRectMake(7.5, CGRectGetHeight(active.frame)-3,CGRectGetWidth(bgView2.frame)-15, 30)];
    tittle.backgroundColor = [UIColor clearColor];
    tittle.font = [UIFont fontWithName:@"Arial" size:11.0];
    tittle.textAlignment = NSTextAlignmentCenter;
    tittle.textColor = [UIColor whiteColor];
    tittle.text = @"加载中";
    [bgView2 addSubview:tittle];
    
}

@end

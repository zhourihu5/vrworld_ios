//
//  SingleTon.h
//  RLLimitApp
//
//  Created by RichyLeo on 15/9/29.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleTon : NSObject

@property (nonatomic, copy) NSString * categoryId;

+(SingleTon *)sharedSingleTon;

@end

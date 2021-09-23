//
//  VideoModel.m
//  VR_world
//
//  Created by XZB on 16/3/15.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end

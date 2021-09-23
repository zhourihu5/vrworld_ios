//
//  VideoDataHelper.m
//  VR_world
//
//  Created by XZB on 16/3/15.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "VideoDataHelper.h"
#import "VideoModel.h"

@implementation VideoDataHelper

static VideoDataHelper *videoDataShare;
+(VideoDataHelper *)VideoDataShare
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (videoDataShare == nil) {
            videoDataShare = [VideoDataHelper new];
        }
    });
    return videoDataShare;
}


@end

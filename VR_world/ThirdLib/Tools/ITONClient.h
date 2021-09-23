//
//  ITONClient.h
//  ITON
//
//  Created by 和易讯 on 14-8-13.
//  Copyright (c) 2014年 heyixun-wd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLoadingView.h"

@interface ITONClient : NSObject

+(NSString*)getFilePathWithFileName:(NSString*)fileName;
//取得存储主要信息的plist文件的路径
+(NSString*)getMainPlistPath;
//获取存储主要信息的plist文件
+(NSMutableDictionary*)getInfoFromMainPlist;
//检查是否该键值在主要信息的plist文件中
+(BOOL)hasKeyInPlist:(NSString*)matchKey;
//添加需要的信息
+(void)addObject:(id<NSObject>)obj forKey:(NSString*)key;
//取某个键值对应的值
+(id)getObjectForKey:(NSString*)key;

//判断文件是否已经存在
+(BOOL)filehadExistAtPath:(NSString*)path;
//保存轨迹的缓存的文件
+(NSMutableArray*)readTraceDataFromCachePlistWithMifiID:(NSString*)mifiID andDateString:(NSString*)dateStr;
+(void)writeTraceDataToCachePlist:(NSArray*)traceArr withDate:(NSString*)dateStr;
+(NSMutableDictionary*)readTraceCacheWithMifiID:(NSString*)mifiID;

//使用mifiID读取轨迹列表的缓存,该mifiID为已经选择的mifiID,轨迹列表的缓存对应的key为traceList
+(NSMutableArray*)readTraceListFromCache;
+(void)writeTraceListWithListData:(NSMutableArray*)listArr;

//获取被选中的fm的频率大小
+(NSString*)getSelectedFMFrequency;
//获取频率的列表
+(NSMutableArray*)getFMFrequencyList;
//将选中频率写入
+(void)setSelectedFMFrequency:(NSString*)fre;
//将频率列表写入，包括用户自定义的列表
+(void)setFMFrequencyList:(NSMutableArray*)listArr;
//将用户自定义的频率插入到文件中
+(void)insertFMFrequencyToList:(NSString*)fre;
//删除列表中的频率 cft
+ (void)removeFMFrequencyWithList:(NSString *)fre;



//添加等待加载提示
+(void)addLoadingView:(UIView *)preview WithTag:(int)tag;
//删除等待加载
+(void)removeLoadingView:(UIView *)preview WithTag:(int)tag;




//判断时间是不是同一天
+(BOOL)isDateTheSameDay:(NSString*)timeStr;
//取年或月或日
+(NSString*)getDAyOrMonthOrYearWithTimeString:(id<NSCopying>)timeString andDateFormat:(NSString*)dateFormat;
//根据日期获取年月日
+(NSString*)getDYMWithDate:(NSDate*)date andFormat:(NSString*)format;

//获取当天的时间
+(NSString*)getDayMonthYear;
//获取当天零点的时间戳
+(NSString*)getDayZeroTimeStamp;
//获取当时的时间戳
+(NSString*)getCurrentTimeStamp;
//根据时间字符串获取时间戳
+(NSString*)getTimeStampWithTimeString:(NSString*)timeStr;
//通过时间戳获取 年月日
+(NSString*)getDayMonthYearWithTimeStamp:(NSString*)timeStamp;
//通过时间戳获取 时分
+(NSString*)getMinuteHourWithTimeStamp:(NSString*)timeStamp;


//获取已经的绑定的所有mifi的名字
+(NSArray*)getMifiNames;


//获取空闲内存
+(natural_t)get_free_memory;

+ (NSString*)deviceString;

@end

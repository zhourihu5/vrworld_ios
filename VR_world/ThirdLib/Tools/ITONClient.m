//
//  ITONClient.m
//  ITON
//
//  Created by 和易讯 on 14-8-13.
//  Copyright (c) 2014年 heyixun-wd. All rights reserved.
//

#import "ITONClient.h"
#import "sys/utsname.h"
#import <mach/mach.h>
#import "ComMethod.h"
#import "StringConstants.h"
@implementation ITONClient

//获取document下特定文件名的文件路径
+(NSString*)getFilePathWithFileName:(NSString*)fileName
{
    
    static NSString *path = nil;
    static dispatch_once_t predictate;
    dispatch_once(&predictate, ^{
        path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:fileName];
    });
    return path;
}

//取得存储主要信息的plist文件的路径
+(NSString*)getMainPlistPath
{
    return [self getFilePathWithFileName:@"mainInfo.plist"];
}

//获取存储主要信息的plist文件
+(NSMutableDictionary*)getInfoFromMainPlist
{
    NSString *filePath = [self getMainPlistPath];
    
    static NSMutableDictionary *sharedDict = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedDict = [[NSMutableDictionary alloc]initWithCapacity:1];
    });
    
    if (sharedDict.count != 0) {
        [sharedDict removeAllObjects];
        
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    [sharedDict setDictionary:dict];
    /*
    for (NSString *key in dict) {
        [sharedDict setObject:[dict objectForKey:key] forKey:key];
    }*/
    return sharedDict;
}
//是否存在某个key
+(BOOL)hasKeyInPlist:(NSString*)matchKey
{
    NSMutableDictionary *dict = [self getInfoFromMainPlist];
    for (NSString *keys in [dict allKeys]) {
        if ([keys isEqualToString:matchKey]) {
            
            NSLog(@"-----+%@",keys);
            return YES;
        }
    }
    dict = nil;
    return NO;
}

//添加需要的信息
+(void)addObject:(id<NSObject>)obj forKey:(NSString*)key
{
    
    if (obj != nil && (![ComMethod isBlankString:key])) {
        NSMutableDictionary *dict = [self getInfoFromMainPlist];
//        NSLog(@"%@",dict[@"mifi"]);
        if (dict == nil) {
            //等于空的时候文件不存在，直接保存
            NSMutableDictionary *saveDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:obj,key, nil];
            [saveDict writeToFile:[self getMainPlistPath] atomically:NO];
        }else{
            //不等空的时候文件存在
            [dict setObject:obj forKey:key];
            NSString *path = [self getMainPlistPath];
//            NSLog(@"222222%@",dict);
//            NSLog(@"path ==%@",path);
            [dict writeToFile:path atomically:NO];
            path = nil;
        }
        dict = nil;
    }else{
        
        
    }
}

//取某个键值对应的值
+(id)getObjectForKey:(NSString*)key
{
    NSMutableDictionary *dict = [self getInfoFromMainPlist];
    NSString *result = [dict objectForKey:key];
    return result;
}


//文件是否存在
+(BOOL)filehadExistAtPath:(NSString*)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        return YES;
    }
    return NO;
}

#pragma mark - 轨迹缓存

//获取轨迹缓存的位置
+(NSString*)getTraceDataCachePath
{
    return [self getFilePathWithFileName:@"traceInfo.plist"];
}

//将轨迹数据写入缓存，key值为年月日
+(void)writeTraceDataToCachePlist:(NSArray*)traceArr withDate:(NSString*)dateStr
{
    if (traceArr != nil && (![ComMethod isBlankString:dateStr])) {
        NSString *path = [self getTraceDataCachePath];
        NSFileManager *fm = [NSFileManager defaultManager];
        NSMutableDictionary *muDict = nil;
        
        //将轨迹数据变成data数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:traceArr];
        //mifi的mac
        NSString *mifiID = [self getObjectForKey:@"selectedMifi"];
        
        NSMutableDictionary *saveDict = nil;
        
        if ([fm fileExistsAtPath:path]) {
            //文件存在
            //读出全部的轨迹信息
            saveDict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
            //读取该mifi的轨迹以及轨迹列表的信息
            muDict = [self readTraceCacheWithMifiID:mifiID];
            
            //首先检查轨迹缓存中有没有该时间段的数据
            BOOL hasThisDate = NO;
            BOOL existInList = NO;
            
            //读取轨迹列表中的时间数据，删除不在列表中的时间的缓存
            NSMutableArray *traceList = [self readTraceListFromCache];
            [traceList removeLastObject];
            
            
            //保存需要删除的轨迹的时间
            NSMutableArray *needDelDate = [[NSMutableArray alloc]initWithCapacity:1];
            
            for (NSString *key in muDict) {
                
                if ([key isEqualToString:dateStr]) {
                    hasThisDate = YES;
                }
                
                
                //检查是否不在缓存的时间列表，不在？删除掉
                for (int i = 0; i < traceList.count;i++) {
                    if ([key isEqualToString:[[traceList objectAtIndex:i] objectAtIndex:1]]) {
                        existInList = YES;
                    }
                    if ([key isEqualToString:@"traceList"]) {
                        existInList = YES;
                    }
                }
                if (existInList == NO) {
                    [needDelDate addObject:key];
                }
            }
            
            for (NSString *key in needDelDate) {
                [muDict removeObjectForKey:key];
            }
            
            
            
            
            //不存在该key,存入
            if (hasThisDate == NO) {
                [muDict setObject:data forKey:dateStr];
            }
        }else{
            saveDict = [[NSMutableDictionary alloc]initWithCapacity:1];
            muDict = [[NSMutableDictionary alloc]initWithCapacity:1];
            //文件不存在，直接写入
            [muDict setObject:data forKey:dateStr];
        }
        if (muDict != nil && (![ComMethod isBlankString:mifiID])) {
            [saveDict setObject:muDict forKey:mifiID];
        }
        
        
        BOOL isWriteSucceed = [saveDict writeToFile:path atomically:NO];
        int writeTimes = 0;
        if (!isWriteSucceed) {
            
            while (!isWriteSucceed) {
                isWriteSucceed = [saveDict writeToFile:path atomically:NO];
                writeTimes++;
                if (writeTimes > 10) {
                    NSLog(@"文件写入失败");
                    break;
                }
            }
        }
    }else{
        
        NSLog(@"写入的轨迹数据是：%@，key是：%@",traceArr,dateStr);
    }
    
    
}
//使用年月日和mifiID来读取轨迹的缓存
+(NSMutableArray*)readTraceDataFromCachePlistWithMifiID:(NSString*)mifiID andDateString:(NSString*)dateStr
{
    NSString *path = [self getTraceDataCachePath];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSMutableDictionary *returnDict = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:mifiID]];
    //取出的数据是转码后的data,取到后进行解码转换
    NSMutableArray *resultArr = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:[returnDict objectForKey:dateStr]]];
    return resultArr;
}
//使用mifiID读取全部缓存
+(NSMutableDictionary*)readTraceCacheWithMifiID:(NSString*)mifiID
{
    NSString *path = [self getTraceDataCachePath];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    //该mifi对应的全部缓存
    NSMutableDictionary *returnDict = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:mifiID]];
    return returnDict;
}

//使用mifiID读取轨迹列表的缓存,该mifiID为已经选择的mifiID,轨迹列表的缓存对应的key为traceList
+(NSMutableArray*)readTraceListFromCache
{
    //取到该mifi所有的缓存数据
    NSMutableDictionary *dict = [self readTraceCacheWithMifiID:[ITONClient getObjectForKey:@"selectedMifi"]];
    //取出轨迹列表
    NSMutableArray *traceListArr = [NSMutableArray arrayWithArray:[dict objectForKey:@"traceList"]];
    return traceListArr;
}
+(void)writeTraceListWithListData:(NSMutableArray*)listArr
{
    if (listArr != nil) {
        NSString *path = [self getTraceDataCachePath];
        NSFileManager *fm = [NSFileManager defaultManager];
        NSMutableDictionary *muDict = nil;
        //mifi的mac
        NSString *mifiID = [self getObjectForKey:@"selectedMifi"];
        if ([fm fileExistsAtPath:path]) {
            //文件存在
            muDict = [self readTraceCacheWithMifiID:mifiID];
            [muDict setObject:listArr forKey:@"traceList"];
        }else{
            muDict = [[NSMutableDictionary alloc]initWithCapacity:1];
            //文件不存在，直接写入
            [muDict setObject:listArr forKey:@"traceList"];
        }
        NSMutableDictionary *allData = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        if (allData == nil) {
            allData = [[NSMutableDictionary alloc]initWithCapacity:1];
        }
        if (muDict != nil &&(![ComMethod isBlankString:mifiID])) {
            [allData setObject:muDict forKey:mifiID];
        }
        
        
        BOOL isWriteSucceed = [allData writeToFile:path atomically:NO];
        int writeTimes = 0;
        if (!isWriteSucceed) {
            while (!isWriteSucceed) {
                isWriteSucceed = [allData writeToFile:path atomically:NO];
                writeTimes++;
                if (writeTimes > 10) {
                    NSLog(@"轨迹里表写入失败");
                    break;
                }
            }
        }
        
    }else{
        NSLog(@"写入的轨迹数据是：%@",listArr);
    }
    
}

#pragma mark - fm频率

//获取被选中的fm的频率大小
+(NSString*)getSelectedFMFrequency
{
    return [self getObjectForKey:@"fmSelected"];
}
//获取频率的列表
+(NSMutableArray*)getFMFrequencyList
{
    return [self getObjectForKey:@"fmList"];
}
//将选中频率写入
+(void)setSelectedFMFrequency:(NSString*)fre
{
    // cft
//    if ([ComMethod isBlankString:fre]) {
//        WDDebugLog(@"写入的频率是：%@",fre);
//    }else{
        [self addObject:fre forKey:@"fmSelected"];
//    }
}
//设置列表
+(void)setFMFrequencyList:(NSMutableArray*)listArr
{
    if (listArr != nil) {
        [self addObject:listArr forKey:@"fmList"];
    }else{
        NSLog(@"写入的频率列表是：%@",listArr);
    }
    
}
//将用户自定义的频率插入到文件中
+(void)insertFMFrequencyToList:(NSString*)fre
{
    if (![ComMethod isBlankString:fre]) {
        NSMutableArray *fmList = [self getObjectForKey:@"fmList"];
        [fmList insertObject:fre atIndex:(fmList.count - 1)];
        [self addObject:fmList forKey:@"fmList"];
    }else{
        NSLog(@"插入的频率是：%@",fre);
    }
    
}
//删除列表中的频率 cft
+ (void)removeFMFrequencyWithList:(NSString *)fre
{
    NSMutableArray *fmList = [self getObjectForKey:@"fmList"];
    [fmList removeObject:fre];
    NSLog(@"%@",fmList);
    [self addObject:fmList forKey:@"fmList"];
}

#pragma mark - 时间戳
//判断时间是不是同一天
+(BOOL)isDateTheSameDay:(NSString*)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    //    [formatter setTimeZone:timeZone];
    
    NSDate *date = [formatter dateFromString:timeStr];
    if ([[self getDayMonthYear] isEqualToString:[formatter stringFromDate:date]]) {
        return YES;
    }
    return NO;
}


+(NSString*)getDAyOrMonthOrYearWithTimeString:(id<NSCopying>)timeString andDateFormat:(NSString*)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    //是正确的时间
    NSDate *date = [formatter dateFromString:(NSString*)timeString];
    
    [formatter setDateFormat:dateFormat];
    
    return [formatter stringFromDate:date];
}

+(NSString*)getDYMWithDate:(NSDate*)date andFormat:(NSString*)format
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dym = [cal components:unitFlags fromDate:date];
    int year = (int)[dym year];
    int month = (int)[dym month];
    int day = (int)[dym day];
    
    if ([format isEqualToString:@"year"]) {
        if (year < 10) {
            return [NSString stringWithFormat:@"0%d",year];
        }else{
            return [NSString stringWithFormat:@"%d",year];
        }
        
    }else if ([format isEqualToString:@"month"]){
        if (month < 10) {
            return [NSString stringWithFormat:@"0%d",month];
        }else{
            return [NSString stringWithFormat:@"%d",month];
        }
        
    }else{
        if (day < 10) {
            return [NSString stringWithFormat:@"0%d",day];
        }else{
            return [NSString stringWithFormat:@"%d",day];
        }
        
    }
    return nil;
}
//获取当天的年月日
+(NSString*)getDayMonthYear
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [NSDate date];
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate:date];
    //    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    NSString *result = [formatter stringFromDate:date];
    
    return result;
}
//获取当天零点的时间戳
+(NSString*)getDayZeroTimeStamp
{
     //当天零点的时间的字符串
    NSString *zeroDateStr = [NSString stringWithFormat:@"%@ 00:00:00",[self getDayMonthYear]];
    
    return [self getTimeStampWithTimeString:zeroDateStr];
}


//获取当时的时间戳
+(NSString*)getCurrentTimeStamp
{
    
    
    NSDate *date2 = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date2];
    
    NSDate *localeDate = [date2  dateByAddingTimeInterval: interval];
    
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];
    return timeStamp;
    
}

//通过时间戳获取 年月日
+(NSString*)getDayMonthYearWithTimeStamp:(NSString*)timeStamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    //是正确的时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    return [formatter stringFromDate:date];
    
}

//通过时间戳获取 时分
+(NSString*)getMinuteHourWithTimeStamp:(NSString*)timeStamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"];
    
    //是正确的时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    return [formatter stringFromDate:date];
}


//将时间字符串转换为时间戳字符串
+(NSString*)getTimeStampWithTimeString:(NSString*)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    //    [formatter setTimeZone:timeZone];
    
    NSDate *date = [formatter dateFromString:timeStr];
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate:date];
    //    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    NSString *timeStamp =[NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    return timeStamp;
}



//添加等待加载提示
+(void)addLoadingView:(UIView *)preview WithTag:(int)tag
{
    CustomLoadingView * loading = [[CustomLoadingView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-75)/2,SCREEN_HEIGHT/2.6, 80, 60)];
    //    loading.tag = tag;
    //    [preview addSubview:loading];
    
    UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [clearView setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.35]];
    clearView.tag = tag;
    [clearView addSubview:loading];
    
    
    [preview.window addSubview:clearView];
}

//删除等待加载
+(void)removeLoadingView:(UIView *)preview WithTag:(int)tag
{
    for(UIView * v in preview.window.subviews){
        //        if([v isKindOfClass:[CustomLoadingView class]] && v.tag == tag){
        //            [v removeFromSuperview];
        //        }
        if (v.tag == tag) {
            [v  removeFromSuperview];
        }
    }
}

+(NSArray*)getMifiNames
{
    NSMutableDictionary *dict = [ITONClient getObjectForKey:@"mifi"];
    NSMutableArray *result = [[NSMutableArray alloc]initWithCapacity:1];
    for (NSString *key in dict) {
        [result addObject:[[dict objectForKey:key] objectAtIndex:0]];
    }
    return [NSArray arrayWithArray:result];
}



+(natural_t) get_free_memory {
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);
    vm_statistics_data_t vm_stat;
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        NSLog(@"Failed to fetch vm statistics");
        return 0;
    }
    /* Stats in bytes */
    natural_t mem_free = (natural_t)(vm_stat.free_count * pagesize);
    return mem_free;
}



+ (NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])
        return @"iPhone 4";
    //为了方便，这里将4s也判断为4
    if ([deviceString isEqualToString:@"iPhone4,1"])
        return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";

    return deviceString;
}



@end

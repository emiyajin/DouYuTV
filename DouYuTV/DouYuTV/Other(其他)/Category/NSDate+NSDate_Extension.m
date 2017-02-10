//
//  NSDate+NSDate_Extension.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/9.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "NSDate+NSDate_Extension.h"

@implementation NSDate (NSDate_Extension)
+(NSString *)getCurrentTime
{
    NSDate *nowDate = [NSDate date];
    //根据服务器请求的参数
    //time 	获取当前时间的字符串 , 这个需要的是计算从1970到现在的时间，精确到秒数
    NSTimeInterval interval = [nowDate timeIntervalSince1970];

    return [NSString stringWithFormat:@"%d",(int)interval];
}
@end

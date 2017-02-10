//
//  RecommandResponse.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/8.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommandResponse : NSObject
/**
 *  存储主播的组的数组
 */
@property (strong,nonatomic) NSMutableArray *anchorGroups;
/**
 *  存储轮播器的一个数组
 */
@property (strong,nonatomic) NSMutableArray *cycles;
/**
 * 单例构造方法
 * @return 请求工具共享实例
 */
+(instancetype)shareRecommandResponse;
/**
 *  请求推荐列表的数据
 */
-(void)requestRecommandData:(void (^)())finishedCallBack;
/**
 *  请求无限轮播数据
 */
-(void)requestCycleData:(void (^)())finishedCallBack;
@end

//
//  RecommandResponse.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/8.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "RecommandResponse.h"
#import <NJAFNetworking.h>
#import "NSDate+NSDate_Extension.h"
#import <MJExtension.h>
#import "AnchorGroup.h"
#import "Anchor.h"
#import "CycleModel.h"

@interface RecommandResponse()
/**
 *  热门主播数据的组
 */
@property (strong,nonatomic) AnchorGroup *bigDataGroup;
/**
 *  颜值主播的组
 */
@property (strong,nonatomic) AnchorGroup *prettyGroup;
/** 创建组 */
@property (strong,nonatomic) dispatch_group_t group;


@end

@implementation RecommandResponse

/**
 单例构造方法

 @return 一个请求工具实例
 */
+(instancetype)shareRecommandResponse
{
    static RecommandResponse *share = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        share = [[RecommandResponse alloc]init];
    });
    return share;
}
#pragma mark -- 懒加载
-(NSMutableArray *)anchorGroups
{
    if (!_anchorGroups) {
        _anchorGroups = [[NSMutableArray alloc]init];
    }
    return _anchorGroups;
}
-(NSMutableArray *)cycles
{
    if (!_cycles) {
        _cycles = [[NSMutableArray alloc]init];
    }
    return _cycles;
}
#pragma mark -- 请求推荐数据
-(void)requestRecommandData:(void (^)())finishedCallBack
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    NSString *currentTime = [NSDate getCurrentTime];
    params[@"limit"] = @"4";
    params[@"offset"] = @"0";
    params[@"time"] = currentTime;
    //创建组 -- 目的是请求到数据之后，保证数据的先后数据，陆续加入到anchorGroups这个数组里
    self.group = dispatch_group_create();
    //1.请求第一部分推荐数据(第0部分)
    [self requstFirstPartData];
    //2.请求第二部分颜值数据(第1部分)
    [self requestPrettyData:params];
    //3.请求后面部分游戏数据(即2-12部分数据)
    [self requestGameData:params];
    //所有数据都请求到之后，来进行排序
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        //XMGLog(@"所有的数据都请求到");
        [self.anchorGroups insertObject:self.prettyGroup atIndex:0];
        [self.anchorGroups insertObject:self.bigDataGroup atIndex:0];

        finishedCallBack();
    });
}
-(void)requstFirstPartData
{
    NSDictionary *params = @{@"time":[NSDate getCurrentTime]};
    //进入组
    dispatch_group_enter(self.group);
    [NJAFNetworking getWithUrl:@"http://capi.douyucdn.cn/api/v1/getbigDataRoom" refreshCache:YES params:params progress:nil success:^(NJServerRequestsStatus status, NJAFNetworkReachabilityStatus reachability, id response)
    {
        //XMGLog(@"%@",response);
        NSArray *dataArr = response[@"data"];
        self.bigDataGroup = [[AnchorGroup alloc]init];
        self.bigDataGroup.tag_name = @"热门";
        self.bigDataGroup.icon_name = @"home_header_hot";
        for (NSDictionary *dict in dataArr) {
            Anchor *anchor = [Anchor mj_objectWithKeyValues:dict];
            [self.bigDataGroup.anchors addObject:anchor];
        }
        //离开组
        dispatch_group_leave(self.group);
        XMGLog(@"请求到第一部分数据");
    } fail:^(NJServerRequestsStatus status, NJAFNetworkReachabilityStatus reachability, id response, NSError *error) {
        NSLog(@"%@",error);
    }];
}
//请求颜值数据
-(void)requestPrettyData:(NSDictionary *)params
{
    //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&currentTime=1486604246
    //进入组
    dispatch_group_enter(self.group);
    [NJAFNetworking getWithUrl:@"http://capi.douyucdn.cn/api/v1/getVerticalRoom" refreshCache:YES params:params progress:nil success:^(NJServerRequestsStatus status, NJAFNetworkReachabilityStatus reachability, id response)
    {
        //XMGLog(@"%@",response);
        NSArray *dataArr = response[@"data"];
        self.prettyGroup = [[AnchorGroup alloc]init];
        self.prettyGroup.tag_name = @"颜值";
        self.prettyGroup.icon_name = @"home_header_phone";
        for (NSDictionary *dict in dataArr) {
            Anchor *anchor = [Anchor mj_objectWithKeyValues:dict];
            [self.prettyGroup.anchors addObject:anchor];
        }
        //离开组
        dispatch_group_leave(self.group);
        XMGLog(@"请求到第二部分数据");
    } fail:^(NJServerRequestsStatus status, NJAFNetworkReachabilityStatus reachability, id response, NSError *error) {

    }];
}
//请求后面的游戏数据
-(void)requestGameData:(NSDictionary *)params
{
    //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&currentTime=1486604246
    //进入组
    dispatch_group_enter(self.group);
    [NJAFNetworking getWithUrl:@"http://capi.douyucdn.cn/api/v1/getHotCate" refreshCache:YES params:params progress:nil success:^(NJServerRequestsStatus status, NJAFNetworkReachabilityStatus reachability, id response)
    {
        //XMGLog(@"%@",response);
        //遍历解析reponse[@"data"],是个字典数组
        for (NSDictionary *dict in response[@"data"]) {
            AnchorGroup *group = [AnchorGroup mj_objectWithKeyValues:dict];
            [self.anchorGroups addObject:group];
        }
//        for (AnchorGroup *group in self.anchorGroups) {
//            for (Anchor *anchor in group.anchors) {
//                //XMGLog(@"%@",anchor.nickname);
//            }
//        }
        //离开组
        dispatch_group_leave(self.group);
        XMGLog(@"请求到第三部分数据");
    } fail:^(NJServerRequestsStatus status, NJAFNetworkReachabilityStatus reachability, id response, NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark -- 请求无限轮播数据
-(void)requestCycleData:(void (^)())finishedCallBack
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"version"] = @"2.300";
    [NJAFNetworking getWithUrl:@"http://www.douyutv.com/api/v1/slide/6" refreshCache:YES params:params progress:nil success:^(NJServerRequestsStatus status, NJAFNetworkReachabilityStatus reachability, id response)
    {
        //XMGLog(@"%@",response);
        NSArray *dataArray = response[@"data"];
        for (NSDictionary *dict in dataArray) {
            CycleModel *cycle = [CycleModel mj_objectWithKeyValues:dict];
            [self.cycles addObject:cycle];
        }
        finishedCallBack();
    } fail:^(NJServerRequestsStatus status, NJAFNetworkReachabilityStatus reachability, id response, NSError *error) {
        XMGLog(@"%@",error);
    }];
}
@end

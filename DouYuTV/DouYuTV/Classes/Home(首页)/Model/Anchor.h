//
//  Anchor.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/9.
//  Copyright © 2017年 emiyajin. All rights reserved.

//一个主播的模型

#import <Foundation/Foundation.h>

@interface Anchor : NSObject

/** 房间ID */
@property (assign,nonatomic) NSInteger room_id;
/**
 *  房间图片对应的URLString
 */
@property (strong,nonatomic) NSString *vertical_src;
/** 判断是手机直播还是电脑直播(0:电脑直播 1:手机直播) */
@property (assign,nonatomic) NSInteger isVertical;
/**
 *  房间名称
 */
@property (strong,nonatomic) NSString *room_name;
/**
 *  主播昵称
 */
@property (strong,nonatomic) NSString *nickname;
/** 在线人数(观看人数) */
@property (assign,nonatomic) NSInteger online;
/**
 *  所在城市
 */
@property (strong,nonatomic) NSString *anchor_city;

@end

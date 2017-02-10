//
//  AnchorGroup.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/9.
//  Copyright © 2017年 emiyajin. All rights reserved.

// 一个主播的组

#import <Foundation/Foundation.h>

@class Anchor;
@interface AnchorGroup : NSObject
/**
 *  该组中对应的房间信息
 */
@property (strong,nonatomic) NSArray *room_list;
/**
 *  组显示的标题
 */
@property (strong,nonatomic) NSString *tag_name;
/**
 *  该组显示的图标
 */
@property (strong,nonatomic) NSString *icon_name;
/**
 *  游戏对应的图标
 */
@property (strong,nonatomic) NSString *icon_url;
/**
 *  存储主播的模型对象数组
 */
@property (strong,nonatomic) NSMutableArray<Anchor *> *anchors;
@end

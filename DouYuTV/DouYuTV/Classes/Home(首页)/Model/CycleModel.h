//
//  CycleModel.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/10.
//  Copyright © 2017年 emiyajin. All rights reserved.

// 轮播模型

#import <Foundation/Foundation.h>
#import "Anchor.h"

@interface CycleModel : NSObject
/**
 *  标题
 */
@property (strong,nonatomic) NSString *title;
/**
 *  展示的图片地址
 */
@property (strong,nonatomic) NSString *pic_url;
/**
 *  主播信息对应的字典
 */
@property (strong,nonatomic) NSDictionary *room;
/**
 *  主播信息对应的模型对象
 */
@property (strong,nonatomic) Anchor *anchorModel;
@end

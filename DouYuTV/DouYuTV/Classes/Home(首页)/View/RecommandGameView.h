//
//  RecommandGameView.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/10.
//  Copyright © 2017年 emiyajin. All rights reserved.

// 推荐模块的推荐游戏

#import <UIKit/UIKit.h>
#import "AnchorGroup.h"

@interface RecommandGameView : UIView
/**
 *  存放主播组的数据
 */
@property (strong,nonatomic) NSMutableArray<AnchorGroup *> *groups;
/**
 *  xib的快速构造方法
 */
+(instancetype)gameView;
@end

//
//  RecommandCycleView.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/10.
//  Copyright © 2017年 emiyajin. All rights reserved.

//推荐顶部可循环利用的轮播器

#import <UIKit/UIKit.h>

@interface RecommandCycleView : UIView
/**
 *  存放轮播器的数组
 */
@property (strong,nonatomic) NSMutableArray *cycleModels;
/**
 *  xib的快速构造方法
 */
+(instancetype)cycleView;

@end

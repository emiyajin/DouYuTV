//
//  CollectionCycleCell.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/10.
//  Copyright © 2017年 emiyajin. All rights reserved.

// 图片轮播的cell

#import <UIKit/UIKit.h>

@class CycleModel;
@interface CollectionCycleCell : UICollectionViewCell
/**
 *  轮播器模型
 */
@property (strong,nonatomic) CycleModel *cycle;
@end

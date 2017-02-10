//
//  CollectionGameCell.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/10.
//  Copyright © 2017年 emiyajin. All rights reserved.

//推荐游戏的cell

#import <UIKit/UIKit.h>
#import "AnchorGroup.h"

@interface CollectionGameCell : UICollectionViewCell
/**
 *  主播组模型
 */
@property (strong,nonatomic) AnchorGroup *group;
@end

//
//  CollectionHeaderView.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/7.
//  Copyright © 2017年 emiyajin. All rights reserved.

//首页推荐界面里的HeaderView

#import <UIKit/UIKit.h>

@class AnchorGroup;
@interface CollectionHeaderView : UICollectionReusableView
/**
 *  主播组
 */
@property (strong,nonatomic) AnchorGroup *group;
@end

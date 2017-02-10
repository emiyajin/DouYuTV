//
//  CollectionPrettyCell.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/7.
//  Copyright © 2017年 emiyajin. All rights reserved.

//首页推荐里面"颜值"栏的cell

#import <UIKit/UIKit.h>
#import "CollectionBaseCell.h"

@interface CollectionPrettyCell : CollectionBaseCell
/**
 所在地点
 */
@property (weak, nonatomic) IBOutlet UIButton *localBtn;
@end

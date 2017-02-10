//
//  CollectionNormalCell.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/7.
//  Copyright © 2017年 emiyajin. All rights reserved.

//首页推荐里面比较普通的cell

#import <UIKit/UIKit.h>
#import "CollectionBaseCell.h"

@interface CollectionNormalCell : CollectionBaseCell
/**
 主播昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@end

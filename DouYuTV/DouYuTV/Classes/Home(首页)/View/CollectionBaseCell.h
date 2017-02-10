//
//  CollectionBaseCell.h
//  DouYuTV
//
//  Created by emiyajin on 17/2/9.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Anchor.h"
#import <UIImageView+WebCache.h>

@interface CollectionBaseCell : UICollectionViewCell
/**
 *  主播模型
 */
@property (strong,nonatomic) Anchor *anchor;
/**
 *  主播图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 房间名称
 */
@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;
/**
 在线人数
 */
@property (weak, nonatomic) IBOutlet UIButton *onLineBtn;
@end

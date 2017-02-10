//
//  CollectionGameCell.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/10.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "CollectionGameCell.h"
#import <UIImageView+WebCache.h>

@interface CollectionGameCell()
/**
 *  主播图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *  主播标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CollectionGameCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setGroup:(AnchorGroup *)group
{
    _group = group;

    //如果发现设置之后图片肿的像猪一样，可以考虑给label添加一个固定高度，来控制图片位置
    self.titleLabel.text = group.tag_name;
    NSURL *iconURL = [NSURL URLWithString:group.icon_url];
    [self.iconView sd_setImageWithURL:iconURL placeholderImage:[UIImage imageNamed:@"home_more_btn"]];
}
@end

//
//  CollectionHeaderView.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/7.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "CollectionHeaderView.h"
#import "AnchorGroup.h"

@interface CollectionHeaderView()
/**
 图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 标签名字
 */
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end

@implementation CollectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setGroup:(AnchorGroup *)group
{
    _group = group;
    self.iconView.image = group.icon_name.length != 0 ? [UIImage imageNamed:group.icon_name] : [UIImage imageNamed:@"home_header_phone"];
    self.tagLabel.text = group.tag_name;
}
@end

//
//  CollectionCycleCell.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/10.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "CollectionCycleCell.h"
#import "CycleModel.h"
#import <UIImageView+WebCache.h>

@interface CollectionCycleCell()
/**
 *   轮播图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *   轮播标题
 */
@property (weak, nonatomic) IBOutlet UILabel *cycleLabel;

@end

@implementation CollectionCycleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCycle:(CycleModel *)cycle
{
    _cycle = cycle;

    self.cycleLabel.text = cycle.title;
    NSURL *iconURL = [NSURL URLWithString:cycle.pic_url];
    [self.iconView sd_setImageWithURL:iconURL placeholderImage:[UIImage imageNamed:@"Img_default"]];
}
@end

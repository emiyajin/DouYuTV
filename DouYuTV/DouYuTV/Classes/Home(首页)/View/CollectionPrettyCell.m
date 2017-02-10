//
//  CollectionPrettyCell.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/7.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "CollectionPrettyCell.h"

@implementation CollectionPrettyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setAnchor:(Anchor *)anchor
{
    [super setAnchor:anchor];

    [self.localBtn setTitle:anchor.anchor_city forState:UIControlStateNormal];
}
@end

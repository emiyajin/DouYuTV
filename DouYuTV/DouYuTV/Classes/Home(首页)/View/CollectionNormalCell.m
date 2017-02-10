//
//  CollectionNormalCell.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/7.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "CollectionNormalCell.h"


@implementation CollectionNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setAnchor:(Anchor *)anchor
{
    [super setAnchor:anchor];

    self.nickNameLabel.text = anchor.nickname;
}
@end

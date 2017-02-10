//
//  CollectionBaseCell.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/9.
//  Copyright © 2017年 emiyajin. All rights reserved.
//
#import "CollectionBaseCell.h"

@implementation CollectionBaseCell
-(void)setAnchor:(Anchor *)anchor
{
    _anchor = anchor;

    self.roomNameLabel.text = anchor.room_name;
    NSString *onlineStr = nil;
    if (anchor.online >= 10000) {
        onlineStr = [NSString stringWithFormat:@"%.1f万在线",(double)anchor.online / 10000];
    }else{
        onlineStr = [NSString stringWithFormat:@"%ld在线",(long)anchor.online];
    }
    [self.onLineBtn setTitle:onlineStr forState:UIControlStateNormal];
    NSURL *url = [NSURL URLWithString:anchor.vertical_src];
    [self.iconView sd_setImageWithURL:url];
}
@end
